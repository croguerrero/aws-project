variable "id" {
  description = "The id of the ECR repository"
  type        = string
  default     = "123456789012"
}
variable "region" {
  description = "The region in which the ECR repository is created"
  type        = string
  default     = "us-west-2"
}