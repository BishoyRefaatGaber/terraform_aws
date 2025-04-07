module "subnet-public-us-east-1a" {
  source            = "./modules/subnet"
  vpc-id            = module.vpc-main.vpc-id
  subnet-cidr       = "10.0.0.0/24"
  subnet-az         = "us-east-1a"
  subnet-tag        = "subnet-public-us-east-1a"
  launch-public-ec2 = true
}

module "subnet-private-us-east-1a" {
  source            = "./modules/subnet"
  vpc-id            = module.vpc-main.vpc-id
  subnet-cidr       = "10.0.1.0/24"
  subnet-az         = "us-east-1a"
  subnet-tag        = "subnet-private-us-east-1a"
  launch-public-ec2 = false
}


module "subnet-public-us-east-1b" {
  source            = "./modules/subnet"
  vpc-id            = module.vpc-main.vpc-id
  subnet-cidr       = "10.0.2.0/24"
  subnet-az         = "us-east-1b"
  subnet-tag        = "subnet-public-us-east-1b"
  launch-public-ec2 = true
}

module "subnet-private-us-east-1b" {
  source            = "./modules/subnet"
  vpc-id            = module.vpc-main.vpc-id
  subnet-cidr       = "10.0.3.0/24"
  subnet-az         = "us-east-1b"
  subnet-tag        = "subnet-private-us-east-1b"
  launch-public-ec2 = false
}

