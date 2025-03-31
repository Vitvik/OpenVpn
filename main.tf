provider "aws" {
  region = "eu-west-1" 
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "lxc_test_sg" {
  name        = "lxc-test-security-group"
  description = "Security group for LXC-Test server"
  vpc_id      = data.aws_vpc.default.id

 
  ingress {
    from_port   = 22
    to_port     = 22
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "lxc_test_server" {
  ami           = "ami-0df368112825f8d8f"  
  instance_type = "t2.micro"
  key_name      = "serv_tren"

  subnet_id             = data.aws_subnets.default.ids[0]  
  vpc_security_group_ids = [aws_security_group.lxc_test_sg.id]

  
  associate_public_ip_address = true
 
  tags = {
    Name = "OpenVpn-Server"
  }
}

output "server_public_ip" {
  value = aws_instance.lxc_test_server.public_ip
}