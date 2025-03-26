resource "aws_launch_template" "web" {
  name_prefix   = "web-app"
  image_id      = "ami-0d0f28110d16ee7d6"    ### Replace with AMI ID 
  instance_type = "t3.micro"
  user_data = file("./bootstrap.sh")
}
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = aws_subnet.public[*].id
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}