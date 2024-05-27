provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      version = ">= 5.5.0"
      source  = "hashicorp/aws"
    }
  }

  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "tester-dev-tfstate"
    key            = "dev/tester-app/terraform.tfstate"
    dynamodb_table = "tester-dev-tfstate-locks"
    region         = "eu-west-1"
    encrypt        = true
  }
}
