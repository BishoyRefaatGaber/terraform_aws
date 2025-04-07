module "vpc-main" {
  source   = "./modules/vpc"
  vpc-cidr = "10.0.0.0/16"
}

module "subnet-public-us-east-1a" {
  source      = "./modules/subnet"
  vpc-id      = module.vpc-main.vpc-id
  subnet-cidr = "10.0.0.0/24"
  subnet-az   = "us-east-1a"
  subnet-tag  = "subnet-public-us-east-1a"
}

module "subnet-private-us-east-1a" {
  source      = "./modules/subnet"
  vpc-id      = module.vpc-main.vpc-id
  subnet-cidr = "10.0.1.0/24"
  subnet-az   = "us-east-1a"
  subnet-tag  = "subnet-private-us-east-1a"
}


module "subnet-public-us-east-1b" {
  source      = "./modules/subnet"
  vpc-id      = module.vpc-main.vpc-id
  subnet-cidr = "10.0.2.0/24"
  subnet-az   = "us-east-1b"
  subnet-tag  = "subnet-public-us-east-1b"
}

module "subnet-private-us-east-1b" {
  source      = "./modules/subnet"
  vpc-id      = module.vpc-main.vpc-id
  subnet-cidr = "10.0.3.0/24"
  subnet-az   = "us-east-1b"
  subnet-tag  = "subnet-private-us-east-1b"
}



module "igw" {
  source = "./modules/igw"
  vpc-id = module.vpc-main.vpc-id
}


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

terraform {
  backend "s3" {
    bucket       = "a-dev-terraform-backend"
    key          = "backend/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
