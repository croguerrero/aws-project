# Define el proveedor de AWS
provider "aws" {
    region = "us-west-2" # Cambia esto a tu región preferida
}

# Crea una aplicación de AWS App Runner
resource "awsapprunner_service" "my_app" {
    name        = "my-app"
    repository  = "https://github.com/myusername/myapp.git" # Cambia esto a la URL de tu repositorio
    branch      = "main" # Cambia esto a la rama de tu repositorio
    instance_configuration {
        cpu    = "1 vCPU"
        memory = "2 GB"
    }
}

# Crea un repositorio en ECR
resource "aws_ecr_repository" "my_app_ecr" {
    name = "my-app-ecr"
}



# Muestra la URL de la aplicación desplegada
output "app_url" {
    value = awsapprunner_service.my_app.service_url
}