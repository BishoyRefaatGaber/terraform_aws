data "aws_key_pair" "ec2-key-pair" {
  key_name           = "ec2-terraform"
  include_public_key = true
}

resource "aws_instance" "ec2" {
  ami                         = var.ec2-img
  instance_type               = "t2.micro"
  associate_public_ip_address = var.pub-ip
  vpc_security_group_ids      = var.sg-id
  subnet_id                   = var.subnet-id
  key_name                    = data.aws_key_pair.ec2-key-pair.key_name
  tags = {
    Name = var.ec2-tag
  }


  connection {
    type         = "ssh"
    user         = "ec2-user"
    host         = var.use_bastion ? self.private_ip : self.public_ip
    private_key  = file("../ec2-terraform.pem")
    bastion_host = var.bastion-host
    bastion_user = var.bastion-user
  }

  provisioner "remote-exec" {
    inline = var.user-data
  }
}