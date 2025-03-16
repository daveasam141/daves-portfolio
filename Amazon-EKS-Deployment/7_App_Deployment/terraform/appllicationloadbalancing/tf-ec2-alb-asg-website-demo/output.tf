# output "public_ip" {
#   value       = formatlist("%s: %s", aws_instance.sh_ec2_launch_templ.*.public_dns, aws_instance.sh_ec2_launch_templ.*.public_ip)
#   description = "Public IP Address of EC2 instance"
# }

# output "instance_id" {
#   value       = aws_instance.sh_ec2_launch_templ.*.id
#   description = "Instance ID"
# }

# output "ssh_connection" {
#   value       = "ssh ec2-user@${aws_launch_template.sh_ec2_launch_templ[0].public_ip}"
#   description = "Connect via SSH"
# }

output "web_connection" {
  value = "http://${aws_lb.sh_lb.arn}"
}


