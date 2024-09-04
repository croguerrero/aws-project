variable "region" {
  description = "The region in which the ECR repository is created"
  type        = string
  default     = "us-east-1"
}

variable "network-security-group-name" {
  description = "The name of the network security group"
  type        = string
  default     = "nsg-inbound"
}