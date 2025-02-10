output "vpc-name" {
  value = aws_vpc.vpc.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "security_group_id" {
  value = aws_security_group.portfolio-sg.id
}

output "ssh_connection" {
  value = "ssh ec2-user@${aws_instance.ec2.public_ip}"
}

output "web_connection" {
  value = "http://${aws_instance.ec2.public_ip}"
}
