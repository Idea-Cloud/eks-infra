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
# GLOBAL
#
################################################################################
variable "region" {
  description = "region"
}

variable "environment" {
  description = "Environment"
}

################################################################################
#
# REMOTE STATE
#
################################################################################
variable "tfstate_bucket" {
  description = "Terraform state bucket"
}

################################################################################
#
# ECR
#
################################################################################
variable "name" {
  description = "Repository name"
  default     = "test"
}
