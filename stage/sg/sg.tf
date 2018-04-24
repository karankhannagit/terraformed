
resource "aws_security_group" "web_server" {
  name = "${var.sg_name}"


  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }

    ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
  }
 egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.egress_cidr_blocks}"]
  }

  vpc_id = "${var.vpc_id}"
}

