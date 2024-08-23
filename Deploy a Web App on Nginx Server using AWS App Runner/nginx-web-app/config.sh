#!/bin/bash

# Configurar AWS CLI
aws configure

# Crear un repositorio ECR
aws ecr create-repository --repository-name my-ecr-repo

# Construir la imagen de Docker
docker build -t my-docker-image .

# Etiquetar la imagen de Docker
docker tag my-docker-image:latest <ECR_REPO_URI>:latest

# Iniciar sesión en ECR
aws ecr get-login-password --region <AWS_REGION> | docker login --username AWS --password-stdin <ECR_REPO_URI>

# Subir la imagen de Docker a ECR
docker push <ECR_REPO_URI>:latest

# Configurar AWS App Runner
aws apprunner create-service --service-name my-apprunner-service --source-configuration "RepositoryType=ECR,RepositoryUrl=<ECR_REPO_URI>,ImageIdentifier=latest"

echo "Configuración completada."