################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_public_a
  availability_zone = "${var.region}a"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_public_b
  availability_zone = "${var.region}b"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_private_a
  availability_zone = "${var.region}a"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_private_b
  availability_zone = "${var.region}b"

  lifecycle {
    ignore_changes = [tags]
  }
}
