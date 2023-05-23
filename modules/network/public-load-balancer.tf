resource "aws_lb" "public-load-balancer" {
  name = "public-load-balancer"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.tf-security-group.id]
  subnets = [ for public-subnet in aws_subnet.public-subnets : public-subnet.id ]

  tags = {
    "Env" = "dev" 
  }
}


resource "aws_lb_target_group" "public-lb-target-group" {
  name = "public-lb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id

}


resource "aws_lb_listener" "public-lb-listener" {
  load_balancer_arn = aws_lb.public-load-balancer.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.public-lb-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "public-tg-attachement" {
  count = length(var.public-target-group-ids)
  target_group_arn = aws_lb_target_group.public-lb-target-group.arn
  target_id =  var.public-target-group-ids[count.index]
  port = 80
}