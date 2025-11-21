resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name

  force_destroy = true
  acl           = "private"

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "ExpireTemp"
    enabled = true
    abort_incomplete_multipart_upload_days = 7
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudFrontRead",
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        },
        Action   = ["s3:GetObject"],
        Resource = ["${aws_s3_bucket.site.arn}/*"]
      }
    ]
  })
}
