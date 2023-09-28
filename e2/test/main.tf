provider "aws" {
  region = "us-east-1"
  alias  = "virginia"

  default_tags {
    tags = {
      "Environment" = "Test"
      "Project"     = "Terraform"
    }
  }
}

module "main" {
  source = "../module"
  providers = {
    aws = aws.virginia
  }
}
