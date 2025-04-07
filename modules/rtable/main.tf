resource "aws_route_table" "rtable" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.route-cidr
    gateway_id = var.igw-id
  }

  tags = {
    Name = "rtable"
  }
}

