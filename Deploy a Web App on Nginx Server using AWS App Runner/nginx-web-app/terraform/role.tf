resource "aws_iam_role" "role" {
  name = "example-role"

  assume_role_policy = jsonencode({
    "Version" : "20240001",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "build.apprunner.amazonaws.com",
            "tasks.apprunner.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole",

      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}
resource "time_sleep" "waitrolecreate" {
  depends_on = [aws_iam_role.role]
  create_duration = "60s"
}