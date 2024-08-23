# Variables
APP_NAME := my-app
AWS_REGION := us-west-2
AWS_ACCOUNT_ID := 

# Funciones
define create_app
	aws apprunner create-service \
		--region $(AWS_REGION) \
		--service-name $(APP_NAME) \
		--source-configuration "RepositoryType=GIT,RepositoryUrl=https://github.com/my-repo.git"
endef

define deploy_app
	aws apprunner create-connection \
		--region $(AWS_REGION) \
		--service-arn $(SERVICE_ARN) \
		--connection-name my-connection \
		--provider-type ECR \
		--connection-arn $(ECR_CONNECTION_ARN)

	aws apprunner create-auto-deployment \
		--region $(AWS_REGION) \
		--service-arn $(SERVICE_ARN) \
		--environment-variables "KEY1=VALUE1,KEY2=VALUE2" \
		--auto-deployment-name my-deployment
endef

define delete_app
	aws apprunner delete-service \
		--region $(AWS_REGION) \
		--service-arn $(SERVICE_ARN)
endef
define create_ecr
	aws ecr create-repository \
		--repository-name $(APP_NAME) \
		--region $(AWS_REGION)
endef
define docker
    aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	docker build -t $(APP_NAME) .
	docker tag $(APP_NAME):latest $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(APP_NAME):latest
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(APP_NAME):latest
endef

# Objetivos
.PHONY: create deploy delete

create:
	$(call create_app)

create:
    $(call docker)

deploy:
	$(call deploy_app)

delete:
	$(call delete_app)