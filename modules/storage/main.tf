resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "bucketVersion" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.VersionStatus
  }
}

