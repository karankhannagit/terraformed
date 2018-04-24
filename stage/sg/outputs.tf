output "sg_id"
{
 value = "${aws_security_group.web_server.id}"
}


output "this_security_group_id" {
  description = "The ID of the security group"
  value       = "${element(concat(aws_security_group.web_server.*.id, list("")), 0)}"
}


output "this_security_group_owner_id" {
  description = "The owner ID"
  value       = "${element(concat(aws_security_group.web_server.*.owner_id, list("")), 0)}"
}

output "this_security_group_name" {
  description = "The name of the security group"
  value       = "${element(concat(aws_security_group.web_server.*.name, list("")), 0)}"
}

output "this_security_group_description" {
  description = "The description of the security group"
  value       = "${element(concat(aws_security_group.web_server.*.description, list("")), 0)}"
}
