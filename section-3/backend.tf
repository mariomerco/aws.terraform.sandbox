terraform {
  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-14wqb0viqin7f"
    key            = "testing"
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-12MAIADF0J8SC"
  }
}
