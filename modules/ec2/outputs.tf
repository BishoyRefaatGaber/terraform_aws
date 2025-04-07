output "ec2-id" {
  description = "get the ec2 id"
  value       = aws_instance.ec2.id
}