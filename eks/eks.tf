################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

locals {
  eks_cluster_name = "eks-${var.environment}-cluster"
}
resource "aws_eks_cluster" "eks-cluster" {
  name     = local.eks_cluster_name
  role_arn = aws_iam_role.eks-cluster.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids         = concat(data.terraform_remote_state.vpc.outputs.public_subnets, data.terraform_remote_state.vpc.outputs.private_subnets)
    security_group_ids = [aws_security_group.eks-cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.eks-cluster
  ]
}

resource "aws_security_group" "eks-cluster" {
  name        = "sgr-${var.environment}-eks-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "null_resource" "create-kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.eks-cluster.name}"
  }

  depends_on = [
    aws_eks_cluster.eks-cluster
  ]
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "ng-${var.environment}-eks-cluster"
  node_role_arn   = aws_iam_role.eks-node-group.arn
  subnet_ids      = data.terraform_remote_state.vpc.outputs.private_subnets

  instance_types = [var.instance_types]

  scaling_config {
    desired_size = var.scaling_size
    max_size     = var.scaling_max_size
    min_size     = var.scaling_min_size
  }

  # move into autoscaler
  tags = map(
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.eks-cluster.name}", "owned",
    "k8s.io/cluster-autoscaler/enabled", "true"
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks-node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-group-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy.eks-node-group-autoscaling
  ]
}
