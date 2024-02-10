terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-zdtqeq4tqvvy"
    key            = "testing"
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-1SOPJGZPR4VKD"
  }
}

provider "aws" {
  default_tags {
    tags = {
      "Environment" = "Test"
      "Project"     = "Terraform"
    }
  }
}
