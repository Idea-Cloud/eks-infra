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
# ECR
#
################################################################################

output "name" {
  value = aws_ecr_repository.ecr.name
}

output "arn" {
  value = aws_ecr_repository.ecr.arn
}

output "registry_id" {
  value = aws_ecr_repository.ecr.registry_id
}

output "repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}
