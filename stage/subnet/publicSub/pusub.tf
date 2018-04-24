resource "aws_subnet" "public" {
  vpc_id                  = "var.vpc_id"
  cidr_block              = "var.psb_cidr"
  map_public_ip_on_launch = true
  availability_zone = "var.az"
  tags = {
  Name =  "var.name"
  }
}


