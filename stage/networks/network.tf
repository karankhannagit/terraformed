
resource "aws_nat_gateway" "nat" {
    allocation_id = "${var.eip_id}"
    subnet_id = "${var.subnet_id}"
    
}


resource "aws_route_table" "private_route_table" {
    vpc_id = "${var.vpc_id}"

    tags {
        Name = "Private route table"
    }
}

resource "aws_route" "private_route" {
        route_table_id  = "${aws_route_table.private_route_table.id}"
        destination_cidr_block = "var.des_cidr_block"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"

}




