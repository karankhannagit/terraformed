resource "aws_network_interface" "this" {
  subnet_id = "${var.subnet_id}"
  private_ips = ["var.ip_range"]


  tags {
    Name = "var.name"
  }
}

