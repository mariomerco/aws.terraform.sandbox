provider "aws" {
  region = "us-west-2"
  alias  = "oregon"

  default_tags {
    tags = {
      "Environment" = "UAT"
      "Project"     = "Terraform"
    }
  }
}

module "main" {
  source = "../module"
  providers = {
    aws = aws.oregon
  }
}
