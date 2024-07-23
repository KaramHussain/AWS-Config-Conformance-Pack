resource "aws_config_conformance_pack" "ConformancePack" {
  name            = var.name
  template_s3_uri = "s3://${var.bucketName}/${var.templateKey}"
}

