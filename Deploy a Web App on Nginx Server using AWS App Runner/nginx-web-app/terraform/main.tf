resource "aws_apprunner_auto_scaling_configuration_version" "ngnix-apprunner-autoscaling" {
  auto_scaling_configuration_name = "demo_auto_scalling"
  max_concurrency                 = 100
  max_size                        = 2
  min_size                        = 1

  tags = {
    Name = "demo_auto_scalling"
  }
}

resource "aws_apprunner_service" "ngnix-apprunner-service-ecr" {
  service_name = "demo_apprunner"

  source_configuration {
    image_repository {
      image_configuration {
        port = "80"
      }
      image_identifier      = "${var.id}.dkr.ecr.us-west-2.amazonaws.com/my-app:latest"
      image_repository_type = "ECR"
    }
    authentication_configuration {
      access_role_arn = aws_iam_role.role.arn
    }
    auto_deployments_enabled = true
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.ngnix-apprunner-autoscaling.arn

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 10
    path                = "/"
    protocol            = "TCP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "demo_apprunner"
  }

}





