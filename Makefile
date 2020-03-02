################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

include ./makefiles/vars.Makefile
include ./makefiles/tools.Makefile
include ./makefiles/kubectl.Makefile
include ./makefiles/docker.Makefile

LOCAL_ENV := "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} TARGET_ENV=${TARGET_ENV} AUTO_APPROVE=${AUTO_APPROVE}"

init-state:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_init-state

_init-state:
	@echo "############## S3 BACKEND STATE ##############"
	@cd state-bucket && make init && make plan && make apply

plan:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_plan

_plan:
	@echo "############## VPC ##############"
	@cd vpc && make init && make plan
	@echo "############## EKS ##############"
	@cd eks && make init && make plan

apply:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_apply

_apply:
	@echo "############## VPC ##############"
	@cd vpc && make init && make apply
	@echo "############## EKS ##############"
	@cd eks && make init && make apply
	@echo "############## kube svc ##############"
	@make kube args="get svc"
	@echo "############## kube nodes ##############"
	@make kube args="get nodes"

destroy:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_destroy

_destroy:
	@echo "############## EKS ##############"
	@cd eks && make init && make destroy
	@echo "############## VPC ##############"
	@cd vpc && make init && make destroy
	@echo "############## S3 BACKEND STATE ##############"
	@cd state-bucket && make init && make destroy

import-state-%: # make import-state-state-bucket args='aws_s3_bucket.terraform_state kjhsdfnbvuio-prod-tfstates'
	@echo "############## IMPORT STATE ##############"
	@cd ${*} && make init && make import-state args="${args}"

format:
	@make make-in-docker LOCAL_ENV=${LOCAL_ENV} MAKE_RULE=_format

_format:
	@echo "############## S3 BACKEND STATE ##############"
	@cd state-bucket && make format
	@echo "############## VPC ##############"
	@cd vpc && make format
	@echo "############## EKS ##############"
	@cd eks && make format
