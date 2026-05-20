data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "app_server" {
  ami                  = data.aws_ami.amazon_linux_2023.id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_profile
  key_name             = "vockey" # Requisito del Learner Lab
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
    #!/bin/bash
    # Amazon Linux 2023 usa dnf/yum, NO apt-get
    dnf update -y
    dnf install -y git curl

    # Instalar Node.js 20
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
    dnf install -y nodejs

    # Clonar repositorio y levantar app
    cd /home/ec2-user
    git clone https://github.com/EnriDv/legacy-users.git
    cd legacy-users
    npm install
    
    # Iniciar la app
    export PORT=${var.app_port}
    export NODE_ENV=produccion
    nohup npm start > app.log 2>&1 &
  EOF

  tags = {
    Name = "LegacyUsers-AppServer"
  }
}