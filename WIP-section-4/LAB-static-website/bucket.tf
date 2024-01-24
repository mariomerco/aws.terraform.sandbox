module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  block_public_policy = false

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
  attach_policy = true
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${module.s3_bucket.s3_bucket_id}",
    ]
  }
}

resource "aws_s3_object" "index_html" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "index.html"
  source = "html/index.html"
}

resource "aws_s3_object" "error_html" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "error.html"
  source = "html/error.html"
}

