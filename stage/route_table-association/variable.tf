variable "subnet_id"
{
description = "default value does not work"

default = "aws_subnet.default_subnet.id"
}


variable "vpc_mainrt"
{
description = "default value does not work"
default ="aws_vpc.cloudroom.main_route_table_id"
}
