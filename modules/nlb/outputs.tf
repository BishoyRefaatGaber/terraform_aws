output "nlb-arn" {
  description = "get the target group arn"
  value       = aws_lb.nlb.arn
}

output "nlb-dns" {
  description = "get the nlb dns"
  value       = aws_lb.nlb.dns_name
}