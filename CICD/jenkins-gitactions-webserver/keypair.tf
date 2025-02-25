# resource "aws_key_pair" "webkey" {
#   key_name   = "web-key"
#   public_key = tls_private_key.oskey.public_key_openssh
# }

# resource "tls_private_key" "oskey" {
#   algorithm = "RSA"
# }

# resource "local_file" "key" {
#   content  = tls_private_key.oskey.private_key_pem
#   filename = "web-key.pem"
# }

### Use when executing on GitLab / GitHub 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "demo"
#   public_key = var.ssh_key_pair
# }

### Use for Jenkins pipleline
resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file("~/.ssh/id_rsa.pub ")
}

### Use when executing locally 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "terraform-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

#####################################

### Use for Jenkins

#####################################

# # This utilizes the TLS provider to generate an SSH key
# resource "tls_private_key" "generated" {
#   algorithm = "RSA"
# }

# # This uses terraform local provider in terraform.tf to save the TLS key to a file called "webkey.pem" in my local file system.
# resource "local_file" "private_key_pem" {
#   content  = tls_private_key.generated.private_key_pem
#   filename = "webkey.pem"
# }

# #Generates a key pair in AWS using the previous TLS key file 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "webkey"
#   public_key = tls_private_key.generated.public_key_openssh

#   lifecycle {
#     ignore_changes = [key_name]
#   }
# }
