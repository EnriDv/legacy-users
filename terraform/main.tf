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

  apt update -y
  apt install -y git curl

  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt install -y nodejs

  cd /home/ubuntu

  git clone https://github.com/EnriDv/legacy-users.git

  cd legacy-users

  npm install

  nohup npm start > app.log 2>&1 &
  EOF
}