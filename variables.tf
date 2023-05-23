variable "public-subnets" {
  type = list(any)
}


variable "private-subnets" {
  type = list(any)
}

variable "availability-zones" {
  type = list(any)
}





variable "private-instance-user-data" {

  default = <<-EOF
          #!/bin/bash
          apt-get update -y
          apt-get install -y apache2
          systemctl restart apache2
      EOF

}



variable "public-instance-user-data" {

  default = <<-EOF
        #!/bin/bash
        apt update -y
        apt install nginx -y
        awk '/server_name _;/ {print; exit} {print}' /etc/nginx/sites-enabled/default > ~/default 
      EOF

}
