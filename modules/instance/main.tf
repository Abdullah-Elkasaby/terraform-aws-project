data "aws_ami" "ubuntu-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical official
}

resource "aws_instance" "public-instances" {
  count = length(var.public-instances-subnets-ids)

  vpc_security_group_ids = var.instances-security-group-ids
  subnet_id              = var.public-instances-subnets-ids[count.index]

  ami           = data.aws_ami.ubuntu-ami.id
  instance_type = "t2.micro"
  key_name      = "mykey"

  user_data = var.public-instance-user-data

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("mykey.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {

    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo unlink /etc/nginx/sites-enabled/default",
      "sudo sh -c 'echo \"server { \n listen 80; \n location / { \n   proxy_pass http://${var.private-dns-name}; \n }  \n  }\" > /etc/nginx/sites-available/reverse-proxy.conf'",
      "sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf",
      "sudo systemctl restart nginx",
    ]
  }



}


resource "aws_instance" "private-instances" {
  count                  = length(var.piravte-instances-subnets-ids)
  vpc_security_group_ids = var.instances-security-group-ids
  subnet_id              = var.piravte-instances-subnets-ids[count.index]

  ami           = data.aws_ami.ubuntu-ami.id
  instance_type = "t2.micro"
  key_name      = "mykey"

  user_data = var.private-instance-user-data

}
