# Variables
APP_NAME := my-app
AWS_REGION := us-west-2
AWS_ACCOUNT_ID := 200281971408

default: deploy_infra

create_ecr:
	aws ecr create-repository \
		--repository-name $(APP_NAME) \
		--region $(AWS_REGION)

delete_ecr:
	aws ecr delete-repository \
		--repository-name $(APP_NAME) \
		--region $(AWS_REGION) \
		--force

docker_build:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	docker build -t $(APP_NAME) .
	docker tag $(APP_NAME):latest $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(APP_NAME):latest
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(APP_NAME):latest
#obtener URL de la imagen
	aws ecr describe-images \
		--repository-name $(APP_NAME) \
		--region $(AWS_REGION) \
		--query 'imageDetails[0].imageTags[0]' \
		--output text

deploy_app_terraform:
	cd terraform && terraform init && terraform plan 

deploy_infra:
    $(MAKE):create_ecr
	$(MAKE):delete_ecr
	$(MAKE):docker_build
	$(MAKE):deploy_app_terraform
	
	