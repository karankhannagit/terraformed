variable "subnet_id"
{
description = "default value doesnt work"
default ="aws_subnet.public.id"
}


variable "ip_range"
{
description = "default value doesnt work"
default ="0.0.0.0"
}


variable "name"
{
description = "default value may work"
default ="default name"
}
