provider "aws" {
  region = "us-east-1"
  alias  = "virginia"

  default_tags {
    tags = {
      "Environment" = "UAT"
      "Project"     = "Terraform"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  alias  = "oregon"

  default_tags {
    tags = {
      "Environment" = "Prod"
      "Project"     = "Terraform"
    }
  }
}

module "main-oregon" {
  source = "../module"
  providers = {
    aws = aws.oregon
  }
}

module "main-virginia" {
  source = "../module"
  providers = {
    aws = aws.virginia
  }
}
