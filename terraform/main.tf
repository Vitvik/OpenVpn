provider "aws" {
  region = var.region
}
/*
provider "aws" {
  region = "eu-west-1" 
}
*/

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

resource "aws_security_group" "vpn_sg" {
  name        = "vpn-security-group"
  description = "Security group for OpenVPN"
  vpc_id      = data.aws_vpc.default.id

 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 1194
  to_port     = 1194
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "project_key" {
  key_name   = "openvpn_ssh"
  public_key = var.public_key
}

resource "aws_instance" "VpnOpen_server" {
  #ami           = "ami-0df368112825f8d8f"  
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #key_name      = "serv_tren"
  key_name      = aws_key_pair.project_key.key_name

  subnet_id             = data.aws_subnets.default.ids[0]  
  vpc_security_group_ids = [aws_security_group.vpn_sg.id]

  associate_public_ip_address = true

  depends_on = [aws_key_pair.project_key]
 /*
  user_data = <<-EOF
  #!/bin/bash -ex
  sudo apt update && sudo apt upgrade -y
  sudo apt-get install git-all -y

  sudo apt-get install software-properties-common -y
  sudo add-apt-repository --yes --update ppa:ansible/ansible -y
  sudo apt install ansible -y

  EOF
*/
  tags = {
    Name = "OpenVpn-Server"
  }
}

output "server_public_ip" {
  value = aws_instance.VpnOpen_server.public_ip
}