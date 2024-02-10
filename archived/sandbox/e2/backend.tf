terraform {
  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-yfwdik1kffgx"
    key            = "testing/e1"
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-24A6YXMCUC9E"
  }
}
