module "vpc-main" {
  source   = "./modules/vpc"
  vpc-cidr = "10.0.0.0/16"
}


terraform {
  backend "s3" {
    bucket       = "a-dev-terraform-backend"
    key          = "backend/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
