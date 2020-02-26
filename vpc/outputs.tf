################################################################################
#
# VPC
#
################################################################################

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
}

output "public_subnets" {
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  description = "Public subnets"
}

output "private_subnets" {
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  description = "Private subnets"
}