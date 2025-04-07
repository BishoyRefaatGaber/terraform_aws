module "igw" {
  source = "./modules/igw"
  vpc-id = module.vpc-main.vpc-id
}

