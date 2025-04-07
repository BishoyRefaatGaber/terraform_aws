output "vpc-id" {
  description = "get the vpc id"
  value       = aws_vpc.main-vpc.id
}