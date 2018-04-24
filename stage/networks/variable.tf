variable "eip_id"
{
description = "default value will not work"
default = "" 
}

variable "vpc_id"
{
description = "default value will not work" 
default = ""
}


variable "subnet_id"
{
default = ""
}


variable "des_cidr_block"
{
default = "0.0.0.0/0"
}

variable "priv_route_table"
{
default = ""
}


variable "aws_nat_id"
{
default = ""
}
