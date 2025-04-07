module "rt" {
  source     = "./modules/rtable"
  vpc-id     = module.vpc-main.vpc-id
  route-cidr = "0.0.0.0/0"
  igw-id     = module.igw.igw-id
}


resource "aws_route_table_association" "route-us-east-1a" {
  subnet_id      = module.subnet-public-us-east-1a.subnet-id
  route_table_id = module.rt.rt-id
}

resource "aws_route_table_association" "route-us-east-1b" {
  subnet_id      = module.subnet-public-us-east-1b.subnet-id
  route_table_id = module.rt.rt-id
}


