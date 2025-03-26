terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cider
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "gw"
  }
}

resource "aws_subnet" "main-public-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.piblic-subnet-cider

  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "main-private-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.private-subnet-cider

  tags = {
    Name = "Private Subnet"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main-public-subnet.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-nat-gateway.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.main-private-subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "allow-http-in-sg" {
  name        = "main-security-group"
  description = "Allow http in"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-security-group"
  }
}



resource "aws_instance" "public-web-ec2" {
  ami                         = "ami-08b5b3a93ed654d19"
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.allow-http-in-sg.id]
  subnet_id                   = aws_subnet.main-public-subnet.id
  associate_public_ip_address = true
  source_dest_check           = true
  user_data                   = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    EOF

  tags = {
    Name = "public-web-ec2"
  }

}


resource "aws_eip" "lb" {
  # instance = aws_instance.public-web-ec2.id
  domain = "vpc"
}

resource "aws_instance" "private-ec2" {
  ami                    = "ami-08b5b3a93ed654d19"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow-http-in-sg.id]
  subnet_id              = aws_subnet.main-private-subnet.id

  tags = {
    Name = "private-ec2"
  }
}

resource "aws_nat_gateway" "public-nat-gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.main-public-subnet.id

  tags = {
    Name = "gw NAT"
  }


  depends_on = [aws_internet_gateway.gw]
}