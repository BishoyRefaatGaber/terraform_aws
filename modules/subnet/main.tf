resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.subnet-cidr
  availability_zone       = var.subnet-az
  map_public_ip_on_launch = var.launch-public-ec2
  tags = {
    Name = var.subnet-tag
  }
}