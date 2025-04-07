resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "main-vpc"
  }
}