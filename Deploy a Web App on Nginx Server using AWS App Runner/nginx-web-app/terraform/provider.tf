terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

provider "aws" {
  region = "us-west-2" # Cambia esto a tu región preferida
  #bucket = "my-bucket" # Cambia esto a tu bucket de S3
  
}