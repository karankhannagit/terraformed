resource "aws_subnet" "private" {
  vpc_id                  = "var.vpc_id"
  cidr_block              = "var.pvs_cidr"
  availability_zone = "var.az"
  tags = {
  Name =  "var.name"
  }
}


