module "network" {
  source = "./modules/network"

  app_port    = var.app_port
  my_public_ip = var.my_public_ip
}

module "compute" {
  source = "./modules/compute"

  instance_type       = var.instance_type
  security_group_id   = module.network.security_group_id
  iam_instance_profile = var.iam_instance_profile

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y git nodejs

              cd /home/ec2-user

              git clone https://github.com/EnriDv/legacy-users.git

              cd legacy-users

              npm install

              nohup npm start > app.log 2>&1 &
              EOF
}