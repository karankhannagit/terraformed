
variable "vpc_id" {
  description = "The vpc id for the VPC. Default value is not valid"
  default     = "module.vp.my_vpc_id"
}

variable "pvs_cidr" {
  description = "The CIDR block for the public subnet. Default value $"
  default     = "172.16.2.0/24"
}

variable "az" {
  description = "Availability zone for the public subnet. Default val$"
  default     = "us-east-2a"
}

variable "name" {
  description = "Availability zone for the public subnet. Default val$"
  default     = "Subnet Priv"
}



