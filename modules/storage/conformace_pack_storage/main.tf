resource "aws_s3_bucket" "conformance_pack_bucket" {
  bucket = "my-unique-conformance-pack-bucket-name"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "conformance_pack_template" {
  bucket = aws_s3_bucket.conformance_pack_bucket.bucket
  key    = "conformance_pack_template.yaml"
  source = "${path.module}/conformance_pack_template.yaml"
  etag   = filemd5("${path.module}/conformance_pack_template.yaml")
}

resource "aws_config_conformance_pack" "conformancepack1" {
    name            = "conformancepack1"
    template_s3_uri = "s3://${aws_s3_bucket.conformance_pack_bucket.bucket}/${aws_s3_bucket_object.conformance_pack_template.key}"

    # depends_on = [aws_config_configuration_recorder.conformancepack1]
}
