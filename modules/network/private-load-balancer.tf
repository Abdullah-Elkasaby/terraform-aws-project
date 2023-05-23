resource "aws_lb" "private-load-balancer" {
  name               = "private-load-balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-security-group.id]
  subnets            = [for private-subnet in aws_subnet.private-subnets : private-subnet.id]

  tags = {
    "Env" = "dev"
  }
}


resource "aws_lb_target_group" "private-lb-target-group" {
  name     = "private-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

}


resource "aws_lb_listener" "private-lb-listener" {
  load_balancer_arn = aws_lb.private-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private-lb-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "private-tg-attachement" {
  count            = length(var.private-target-group-ids)
  target_group_arn = aws_lb_target_group.private-lb-target-group.arn
  target_id        = var.private-target-group-ids[count.index]
  port             = 80
}
