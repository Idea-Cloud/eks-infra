################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "ngw_public_a" {
  allocation_id = aws_eip.nat_public_a.id
  subnet_id     = aws_subnet.public_a.id
}

resource "aws_eip" "nat_public_a" {
  vpc = true

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "ngw_public_b" {
  allocation_id = aws_eip.nat_public_b.id
  subnet_id     = aws_subnet.public_b.id
}

resource "aws_eip" "nat_public_b" {
  vpc = true

  depends_on = [aws_internet_gateway.igw]
}
