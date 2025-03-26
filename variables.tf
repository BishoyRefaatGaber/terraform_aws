variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}
variable "vpc-cider" {
  description = "vpc cider"
  type        = string
  default     = "10.0.0.0/16"
}
variable "piblic-subnet-cider" {
  description = "public subnet cider"
  type        = string
  default     = "10.0.1.0/24"
}
variable "private-subnet-cider" {
  description = "instance type"
  type        = string
  default     = "10.0.0.0/24"
}
