variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-e82a1a8d"
    
  }
 
}
variable "aws_access_key" {
  default = "your-key"
  description = "the user aws access key"
}
variable "aws_secret_key" {
  default = "your-key"
  description = "the user aws secret key"
}


variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "vpc_name1"
{
  description = "Name to be used on all the resources as identifier"
  default     = "cloudroom"

}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid "
  default     = "172.16.0.0/16"
}



variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {}
}

variable "default_vpc_name" {
  description = "Name to be used on the Default VPC"
  default     = ""
}

variable "default_vpc_enable_dns_support" {
  description = "Should be true to enable DNS support in the Default VPC"
  default     = true
}

variable "default_vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the Default VPC"
  default     = false
}



