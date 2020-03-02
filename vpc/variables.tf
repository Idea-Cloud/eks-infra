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
# VPC
#
################################################################################
variable "cidr_block" {
  description = "VPC CIDR block"
}

variable "cidr_block_public_a" {
  description = "VPC CIDR block subnet public AZ a"
}

variable "cidr_block_public_b" {
  description = "VPC CIDR block subnet public AZ b"
}

variable "cidr_block_private_a" {
  description = "VPC CIDR block subnet private AZ a"
}

variable "cidr_block_private_b" {
  description = "VPC CIDR block subnet private AZ b"
}
