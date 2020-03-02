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

variable "vpc_tfstate_key" {
  description = "VPC tfstate key"
}

################################################################################
#
# EKS
#
################################################################################
variable "instance_types" {
  description = "Node instance type"
  default     = "t3.nano"
}

variable "scaling_size" {
  default = 2
}

variable "scaling_max_size" {
  default = 4
}

variable "scaling_min_size" {
  default = 1
}

variable "cluster_autoscaler_version" {
  default = "v1.17.7"
}
