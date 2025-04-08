variable "ec2-tag" {}

variable "subnet-id" {}

variable "sg-id" {}

variable "pub-ip" {}

variable "user-data" {}

variable "bastion-host" {

}

variable "bastion-user" {}



variable "use_bastion" {
  type    = bool
  default = false
}

variable "ec2-img" {

}