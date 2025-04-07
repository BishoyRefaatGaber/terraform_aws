resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc-id
  cidr_block        = var.subnet-cidr
  availability_zone = var.subnet-az
  tags = {
    Name = var.subnet-tag
  }
}