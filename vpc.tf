module "vpc-main" {
  source   = "./modules/vpc"
  vpc-cidr = "10.0.0.0/16"
}
