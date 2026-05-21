resource "aws_instance" "app_server" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile = var.iam_instance_profile

  key_name = "legacy-users-key"

  user_data = var.user_data

  tags = {
    Name = "legacy-users-server"
  }
}