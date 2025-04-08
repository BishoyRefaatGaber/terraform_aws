output "ec2-id" {
  description = "get the ec2 id"
  value       = aws_instance.ec2.id
}

output "ec2-public-ip" {
  description = "get the public ip"
  value       = aws_instance.ec2.public_ip
}
output "ec2-private-ip" {
  description = "get the public ip"
  value       = aws_instance.ec2.private_ip
}