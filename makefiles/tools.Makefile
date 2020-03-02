################################################################################
# This file is part of the "eks-infra" project.
#
# Copyright (C) 2020 - Gamaliel SICK, IDEACLOUD.
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
################################################################################

download-terraform:
	@mkdir -p ${ROOT_DIR}/.bin
    ifeq ("$(wildcard ${ROOT_DIR}/.bin/terraform)","")
		@echo "Downloading terraform"
        ifeq ($(OS), Darwin)
			@curl -L https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_darwin_amd64.zip > ${ROOT_DIR}/.bin/.terraform.zip
			@unzip -od ${ROOT_DIR}/.bin ${ROOT_DIR}/.bin/.terraform.zip
			@rm ${ROOT_DIR}/.bin/.terraform.zip
			@chmod +x ${ROOT_DIR}/.bin/terraform
        endif
        ifeq ($(OS), Linux)
			@curl -L https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip > ${ROOT_DIR}/.bin/.terraform.zip
			@unzip -od ${ROOT_DIR}/.bin ${ROOT_DIR}/.bin/.terraform.zip
			@rm ${ROOT_DIR}/.bin/.terraform.zip
			@chmod +x ${ROOT_DIR}/.bin/terraform
        endif
        ifeq ($(OS), CYGWIN_NT-6.1)
			@curl --insecure -L https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_windows_amd64.zip > ${ROOT_DIR}/.bin/.terraform.zip
			@unzip -od ${ROOT_DIR}/.bin ${ROOT_DIR}/.bin/.terraform.zip
			@rm ${ROOT_DIR}/.bin/.terraform.zip
			@chmod +x ${ROOT_DIR}/.bin/terraform
        endif
    endif

download-kubectl:
	@mkdir -p ${ROOT_DIR}/.bin
    ifeq ("$(wildcard ${ROOT_DIR}/.bin/kubectl)","")
		@echo "Downloading kubectl"
        ifeq ($(OS), Darwin)
			@curl -L -o ${ROOT_DIR}/.bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/darwin/amd64/kubectl
			@chmod +x ${ROOT_DIR}/.bin/kubectl
        endif
        ifeq ($(OS), Linux)
			@curl -L -o ${ROOT_DIR}/.bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
			@chmod +x ${ROOT_DIR}/.bin/kubectl
        endif
        ifeq ($(OS), CYGWIN_NT-6.1)
			@curl --insecure -L -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/windows/amd64/kubectl.exe
			@chmod +x ${ROOT_DIR}/.bin/kubectl
        endif
    endif

install:
#	@make download-terraform
#	@${TERRAFORM_CMD} version
#	@make download-kubectl
#	@${KUBECTL_CMD} version --short --client
	@echo "Building Docker image \"${DOCKER_IMAGE_NAME}\""
	@docker build -t ${DOCKER_IMAGE_NAME} .

uninstall:
	@docker rmi -f ${DOCKER_IMAGE_NAME}

env:
	@$(foreach v, $(.VARIABLES), $(info $(v) = $($(v))))
