variable "region" {
  default = "us-east-2"
}
variable "AmiLinux" {
  type = "map"
  default = {
    us-east-2 = "ami-e82a1a8d"

  }

}


variable "instance_type"
{
description = "" 
default = "t2.micro"
}

variable "net_int_id"
{

description = "to be fetched from output file of net interface" 
default = ""

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


