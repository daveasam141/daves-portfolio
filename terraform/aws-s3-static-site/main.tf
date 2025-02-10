####################################################
# S3 static website bucket
####################################################
resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-bucket"
  })
}

####################################################
# S3 public access settings
####################################################
resource "aws_s3_bucket_public_access_block" "static_site_bucket_public_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

####################################################
# S3 bucket policy
####################################################
resource "aws_s3_bucket_policy" "static_site_bucket_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Principal = "*"
        Action = [
          "s3:GetObject",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.static_site_bucket_public_access]
}


####################################################
# S3 bucket static website configuration
####################################################
resource "aws_s3_bucket_website_configuration" "static_site_bucket_website_config" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
/*
####################################################
# S3 bucket ownership controls and ACL (recommended if you want object level control).
####################################################
resource "aws_s3_bucket_ownership_controls" "static_site_bucket_ownership_controls" {
  bucket = aws_s3_bucket.my-static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "static_site_bucket_acl" {
  depends_on = [
    # aws_s3_bucket_ownership_controls.static_site_bucket_ownership_controls,
    aws_s3_bucket_public_access_block.static_site_bucket_public_access,
  ]

  bucket = aws_s3_bucket.my-static_website.id
  acl    = "public-read"
}
*/

####################################################
# Upload files to S3 Bucket 
####################################################
resource "aws_s3_object" "provision_source_files" {
  bucket = aws_s3_bucket.static_website.id

  # webfiles/ is the Directory contains files to be uploaded to S3
  for_each = fileset("webfiles/", "**/*.*")

  key          = each.value
  source       = "webfiles/${each.value}"
  content_type = each.value
  #acl          = "public-read" #use this only if you are using Bucket and Object ACLs, defaults to private
}