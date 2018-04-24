variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-e82a1a8d"

  }

}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "instance_type"
{
description = "" 
default = "t2.micro"
}



variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
}


variable "net_int_id"
{

description = "to be fetched from output file of net interface" 
default = ""

}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "keyname"
{
description = "key name is for demo purpose" 
default = "mykeyname"

}


variable "instance_name"
{
description = "name of instance may work" 
default = "node"

}


