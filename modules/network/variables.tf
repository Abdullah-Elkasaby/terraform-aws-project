

variable "vpc-cidr" {
  description = "the vpc cidr_block "
  type = string
  default = "10.0.0.0/16"
}

variable "vpc-tags" {
  description = "tags that are assigned to a vpc"
  type = map(string)
  default = {
    "Name" = "tf-vpc"
  }
}

variable "igw-tags" {
  type = map(string)
  default = {
    "Name" = "tf-internet-gateway"
  }
}


variable "public-subnets-cidr-blocks" {
  description = "public subnets cidr_blocks"
  type = list
  
}


variable "private-subnets-cidr-blocks" {
  description = "private subnets cidr_blocks"
  type = list
  
}

variable "zones" {
    description = "list of availability zones"
    type = list
  
}

variable "public-target-group-ids" {
  type = list
}


variable "private-target-group-ids" {
  type = list
}

