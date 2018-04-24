resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
  tags {
        Name = "var.ig_name"
    }
}



resource "aws_eip" "eipmod" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

