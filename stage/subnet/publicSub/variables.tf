variable "vpc_name" {
  description = "The CIDR block for the VPC. Default value is a valid "
  default     = "cloudroom"
}

variable "vpc_id" {
  description = "The vpc id for the VPC. Default value is not valid"
  default     = ""
}

variable "psb_cidr" {
  description = "The CIDR block for the public subnet. Default value is a valid"
  default     = "172.16.1.0/24"
}

variable "az" {
  description = "Availability zone for the public subnet. Default value"
  default     = "us-east-2a"
}

variable "name" {
  description = "Availability zone for the public subnet. Default val"
  default     = "Subnet Pub"
}


