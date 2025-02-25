output "public_ip" {
  value       = formatlist("%s: %s", aws_instance.ec2-demo.*.public_dns, aws_instance.ec2-demo.*.public_ip)
  description = "Public IP Address of EC2 instance"
}

output "instance_id" {
  value       = aws_instance.ec2-demo.*.id
  description = "Instance ID"
}

output "ssh_connection" {
  value       = "ssh ec2-user@${aws_instance.ec2-demo.public_ip}"
  description = "Connect via SSH"
}

output "web_connection" {
  value       = "http://${aws_instance.ec2-demo.public_ip}"
  description = "Connect via SSH"
}
