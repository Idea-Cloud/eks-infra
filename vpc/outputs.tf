################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

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
