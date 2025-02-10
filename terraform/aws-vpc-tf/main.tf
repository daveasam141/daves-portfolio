
resource "aws_instance" "ec2" {
  subnet_id              = aws_subnet.public_subnet.id
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.portfolio-key.key_name
  vpc_security_group_ids = [aws_security_group.portfolio-sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum -y install httpd git
  sudo yum -y  update
  cd /tmp
  git clone https://github.com/emage-course/portfolio.git
  sleep 15s
  cd /tmp/portfolio/website
  cp -r *  /var/www/html/
  sudo systemctl stop httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  EOF

  tags = {
    Name        = "portfolio.example.com"
    Environment = "production"
    Owner       = "Cloud team"
  }
}

