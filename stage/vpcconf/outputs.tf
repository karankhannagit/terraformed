# VPC
output "my_vpc_id" {
  description = "The ID of the VPC"
   value       = "${aws_vpc.myvpc.id}"
}


output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = "${element(concat(aws_vpc.myvpc.*.main_route_table_id, list("")), 0)}"
}
