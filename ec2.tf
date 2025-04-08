module "ec2-public-us-east-1a" {
  source    = "./modules/ec2"
  pub-ip    = true
  ec2-tag   = "ec2-public-us-east-1a"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-public-us-east-1a.subnet-id
  user-data = [
    "sudo yum install -y nginx",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    "echo 'server { listen 80; location / { proxy_pass http://${module.nlb-private.nlb-dns}; }}' | sudo tee /etc/nginx/conf.d/proxy.conf",
    "sudo systemctl restart nginx"
  ]
  use_bastion  = false
  bastion-host = ""
  bastion-user = ""
}

module "ec2-public-us-east-1b" {
  source    = "./modules/ec2"
  pub-ip    = true
  ec2-tag   = "ec2-public-us-east-1b"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-public-us-east-1b.subnet-id
  user-data = [
    "sudo yum install -y nginx",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    "echo 'server { listen 80; location / { proxy_pass http://${module.nlb-private.nlb-dns}; }}' | sudo tee /etc/nginx/conf.d/proxy.conf",
    "sudo systemctl restart nginx"
  ]
  use_bastion  = false
  bastion-host = ""
  bastion-user = ""
}

module "ec2-private-us-east-1a" {
  source    = "./modules/ec2"
  pub-ip    = false
  ec2-tag   = "ec2-private-us-east-1a"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-private-us-east-1a.subnet-id
  user-data = [
    "sudo yum install -y nginx",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    "echo 'Hello from Web Server 1' | sudo tee /usr/share/nginx/html/index.html",
    "sudo systemctl restart nginx"
  ]
  use_bastion  = true
  bastion-host = module.ec2-public-us-east-1a.ec2-public-ip
  bastion-user = "ec2-user"
  depends_on   = [module.ec2-public-us-east-1a]

}

module "ec2-private-us-east-1b" {
  source    = "./modules/ec2"
  pub-ip    = false
  ec2-tag   = "ec2-private-us-east-1b"
  sg-id     = [module.sgroup.sg-id]
  subnet-id = module.subnet-private-us-east-1b.subnet-id
  user-data = [
    "sudo yum install -y nginx",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    "echo 'Hello from Web Server 2' | sudo tee /usr/share/nginx/html/index.html",
    "sudo systemctl restart nginx"
  ]
  bastion-host = module.ec2-public-us-east-1b.ec2-public-ip
  bastion-user = "ec2-user"
  depends_on   = [module.ec2-public-us-east-1b]
  use_bastion  = true
}
