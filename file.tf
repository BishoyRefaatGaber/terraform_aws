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
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id
}

resource "aws_subnet" "main-public-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "main-private-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.0.0/24"

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
  subnet_id      = aws_subnet.main-subnet.id
  route_table_id = aws_route_table.public.id
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
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow-http-in-sg.id]
  subnet_id                   = aws_subnet.main-public-subnet.id
  associate_public_ip_address = true
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

resource "aws_instance" "private-ec2" {
  ami                         = "ami-08b5b3a93ed654d19"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.allow-http-in-sg.id]
  subnet_id                   = aws_subnet.main-private-subnet.id
  associate_public_ip_address = true
  source_dest_check           = true

  tags = {
    Name = "private-ec2"
  }
}


data "aws_nat_gateway" "web-nat-gatewat" {
  subnet_id = aws_subnet.main-public-subnet.id
  tags = {
    Name = "web nat gateway"
  }
}