################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_ecr_repository" "ecr" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
