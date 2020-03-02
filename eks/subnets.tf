################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "null_resource" "private_subnet_tags" {
  count = length(data.terraform_remote_state.vpc.outputs.private_subnets)
  provisioner "local-exec" {
    command = "aws --region ${var.region} ec2 create-tags --resources ${element(data.terraform_remote_state.vpc.outputs.private_subnets, count.index)} --tags Key=kubernetes.io/role/internal-elb,Value=1 --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws --region ${var.region} ec2 delete-tags --resources ${element(data.terraform_remote_state.vpc.outputs.private_subnets, count.index)} --tags Key=kubernetes.io/role/internal-elb,Value=1 --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }
}

resource "null_resource" "public_subnet_tags" {
  count = length(data.terraform_remote_state.vpc.outputs.public_subnets)
  provisioner "local-exec" {
    command = "aws --region ${var.region} ec2 create-tags --resources ${element(data.terraform_remote_state.vpc.outputs.public_subnets, count.index)} --tags Key=kubernetes.io/role/elb,Value=1 --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws --region ${var.region} ec2 delete-tags --resources ${element(data.terraform_remote_state.vpc.outputs.public_subnets, count.index)} --tags Key=kubernetes.io/role/elb,Value=1 --tags Key=kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.name},Value=shared"
  }

  depends_on = [
    aws_eks_cluster.eks-cluster
  ]
}
