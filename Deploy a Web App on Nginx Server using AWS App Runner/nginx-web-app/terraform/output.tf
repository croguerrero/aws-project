# Muestra la URL de la aplicación desplegada
output "app_url" {
  value = "https://${aws_apprunner_service.ngnix-apprunner-service-ecr.service_url}"
}