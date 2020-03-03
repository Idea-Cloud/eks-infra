################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_cloudwatch_log_group" "eks-cluster" {
  name              = "/aws/eks/${local.eks_cluster_name}/cluster"
  retention_in_days = 7
}
