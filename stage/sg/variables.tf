
variable "vpc_id"
{
  description = "Name to be used on all the resources as identifier"
  default     = ""

}

variable "sg_name"
{
  description = "Name to be used on all the resources as identifier"
  default     = "web_server_cr"

}


variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  default     = []
}
