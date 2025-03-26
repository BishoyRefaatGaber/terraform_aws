output "public-ec2-ip" {
  description = "web ec2 ip"
  value       = aws_instance.public-web-ec2.public_ip
}

output "private-ec2-ip" {
  description = "private ec2 ip"
  value       = aws_instance.private-ec2.public_ip
} 