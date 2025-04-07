module "ec2-public-us-east-1a" {
  source    = "./modules/ec2"
  pub-ip    = true
  ec2-tag   = "ec2-public-us-east-1a"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-public-us-east-1a.subnet-id
}

module "ec2-public-us-east-1b" {
  source    = "./modules/ec2"
  pub-ip    = true
  ec2-tag   = "ec2-public-us-east-1b"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-public-us-east-1b.subnet-id
}

module "ec2-private-us-east-1a" {
  source    = "./modules/ec2"
  pub-ip    = false
  ec2-tag   = "ec2-private-us-east-1a"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-private-us-east-1a.subnet-id
}

module "ec2-private-us-east-1b" {
  source    = "./modules/ec2"
  pub-ip    = false
  ec2-tag   = "ec2-private-us-east-1b"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-private-us-east-1b.subnet-id
}
