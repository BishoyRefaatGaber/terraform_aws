
# ###############################################################################
# # PROVIDER
# ###############################################################################
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
# }

# ###############################################################################
# # NETWORK: VPC, IGW, SUBNET, ROUTES
# ###############################################################################
# # 1. Create a VPC
# resource "aws_vpc" "main_vpc" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "demo-vpc"
#   }
# }

# # 2. Create an Internet Gateway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "demo-igw"
#   }
# }

# # 3. Create a Public Subnet (10.0.0.0/24)
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = "10.0.0.0/24"
#   map_public_ip_on_launch = true # ensures instances get public IPs

#   tags = {
#     Name = "demo-public-subnet"
#   }
# }

# # 4. Create a Route Table for the Public Subnet
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "demo-public-rt"
#   }
# }

# # 5. Add a default route to the IGW
# resource "aws_route" "public_route" {
#   route_table_id         = aws_route_table.public_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# # (Optional) IPv6 default route if you have an IPv6 CIDR
# # resource "aws_route" "public_route_ipv6" {
# #   route_table_id         = aws_route_table.public_rt.id
# #   destination_ipv6_cidr_block = "::/0"
# #   gateway_id             = aws_internet_gateway.igw.id
# # }

# # 6. Associate the Public Subnet with the Route Table
# resource "aws_route_table_association" "public_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

# ###############################################################################
# # SECURITY GROUP
# ###############################################################################
# # 7. Create a Security Group to allow HTTP (port 80) and SSH (port 22 if desired)
# resource "aws_security_group" "apache_sg" {
#   name        = "demo-apache-sg"
#   description = "Allow HTTP and SSH"
#   vpc_id      = aws_vpc.main_vpc.id

#   ingress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Optional SSH rule
#   ingress {
#     description = "Allow SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outbound"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "demo-apache-sg"
#   }
# }

# ###############################################################################
# # EC2 INSTANCE
# ###############################################################################
# # 8. Launch an EC2 instance in the Public Subnet
# resource "aws_instance" "apache_ec2" {
#   ami           = "ami-08b5b3a93ed654d19" # Example Amazon Linux 2 AMI; update for your region
#   instance_type = "t2.micro"

#   # Attach the security group
#   vpc_security_group_ids = [aws_security_group.apache_sg.id]

#   subnet_id = aws_subnet.public_subnet.id

#   associate_public_ip_address = true #----------------------------------------------------------------------------------------------------------------------------------->

#   # User data to install and start Apache
#   user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y httpd
#     systemctl start httpd
#     systemctl enable httpd
#   EOF

#   tags = {
#     Name = "demo-apache-ec2"
#   }
# }
