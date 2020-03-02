################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  lifecycle {
    ignore_changes = [tags]
  }
}
