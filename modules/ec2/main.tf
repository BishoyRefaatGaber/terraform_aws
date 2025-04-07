data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-00a92*"]
  }

  owners = ["amazon"]
}


resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = "t2.micro"
  associate_public_ip_address = var.pub-ip
  vpc_security_group_ids      = var.sg-id
  subnet_id                   = var.subnet-id
  tags = {
    Name = var.ec2-tag
  }
}