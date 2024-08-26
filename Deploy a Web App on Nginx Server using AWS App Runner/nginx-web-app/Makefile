# Variables
APP_NAME := my-app
AWS_REGION := us-west-2
AWS_ACCOUNT_ID := 200281971408# Set your AWS account ID

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

plan_tf:
	cd terraform && terraform init && terraform plan -var="id=$(AWS_ACCOUNT_ID)" 

apply_tf:
	cd terraform && terraform apply -var="id=$(AWS_ACCOUNT_ID)" -auto-approve

destroy_tf:
	cd terraform && terraform destroy -var="id=$(AWS_ACCOUNT_ID)" -auto-approve

deploy_infra:
    $(MAKE):create_ecr
	$(MAKE):delete_ecr
	$(MAKE):docker_build
	$(MAKE):plan_tf
	$(MAKE):apply_tf
	
	