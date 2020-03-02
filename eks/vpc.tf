################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "null_resource" "vpc_tags" {
  provisioner "local-exec" {
    command = "aws --region ${var.region} ec2 create-tags --resources ${data.terraform_remote_state.vpc.outputs.vpc_id} --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws --region ${var.region} ec2 delete-tags --resources ${data.terraform_remote_state.vpc.outputs.vpc_id} --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }

  depends_on = [
    aws_eks_cluster.eks-cluster
  ]
}
