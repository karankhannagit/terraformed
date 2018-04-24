resource "aws_route" "internet_access" {
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "var.dest_cidr_block"
  gateway_id             = "${var.gateway_id}"
}

