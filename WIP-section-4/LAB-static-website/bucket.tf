module "s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  attach_policy = true

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
  # attach_public_policy = true
  block_public_policy     = false
  block_public_acls       = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  policy                  = data.aws_iam_policy_document.bucket_policy.json
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
      "${module.s3_bucket.s3_bucket_arn}/*",
    ]
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = module.s3_bucket.s3_bucket_id
  key          = "index.html"
  source       = "html/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = module.s3_bucket.s3_bucket_id
  key          = "error.html"
  source       = "html/error.html"
  content_type = "text/html"
}

