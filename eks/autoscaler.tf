################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

#resource "null_resource" "apply-autoscaler" {
#  provisioner "local-exec" {
#    command = "cat <<EOF | kubectl apply -f -\n${templatefile("${path.module}/cluster-autoscaler-autodiscover.yaml.tmpl", { cluster_name = aws_eks_cluster.eks-cluster.name, autoscaler_version = var.cluster_autoscaler_version })} \nEOF"
#  }
#
#  provisioner "local-exec" {
#    when    = destroy
#    command = "cat <<EOF | kubectl delete -f -\n${templatefile("${path.module}/cluster-autoscaler-autodiscover.yaml.tmpl", { cluster_name = aws_eks_cluster.eks-cluster.name, autoscaler_version = var.cluster_autoscaler_version })} \nEOF"
#  }

#  depends_on = [
#    null_resource.create-kubeconfig
#  ]
#}

#resource "null_resource" "annotate-autoscaler" {
#  provisioner "local-exec" {
#    command = "kubectl -n kube-system annotate --overwrite deployment.apps/cluster-autoscaler cluster-autoscaler.kubernetes.io/safe-to-evict=\"false\""
#  }
#
#  depends_on = [
#    null_resource.apply-autoscaler
#  ]
#}

#resource "null_resource" "image-autoscaler" {
#  provisioner "local-exec" {
#    command = "kubectl -n kube-system set image deployment.apps/cluster-autoscaler cluster-autoscaler=k8s.gcr.io/cluster-autoscaler:${var.cluster_autoscaler_version}"
#  }
#
#  depends_on = [
#    null_resource.annotate-autoscaler
#  ]
#}
