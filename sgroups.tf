module "sgroup" {
  source = "./modules/sgroup"
  vpc-id = module.vpc-main.vpc-id
}

