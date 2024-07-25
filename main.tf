provider "aws" {
  region = var.region
}


## Creating Policy For AWS Config Recorder

module "config_policy" {
  source = "./modules/IAM/config_policy"
  name   = var.configRecorder_policy_name
}

## Creating Role For AWS Config Recorder

module "config_role" {
  source = "./modules/IAM/config_role"
  name   = var.configRecorder_role_name
}


## Attaching Policy to Role

resource "aws_iam_role_policy_attachment" "config_policy_attachment" {
  role       = var.configRecorder_role_name
  policy_arn = module.config_policy.aws_config_service_policy_arn
}


## Creating S3 Bucket for Recorder

module "Recorder_S3_Bucket" {
  source        = "./modules/storage"
  bucket_name   = var.RecorderBucketName
  VersionStatus = "Enabled"
}


## Creating AWS Config Recorder

module "recorder" {
  source     = "./modules/recorder"
  name       = var.configRecorder_name
  role_arn   = module.config_role.config_role_arn
  bucketName = var.RecorderBucketName
}


## Creating Bucket for Conformance Pack Template 1

module "ConformancePacke1_s3_bucket" {
  source        = "./modules/storage"
  bucket_name   = var.ConformancePack1_bucketName
  VersionStatus = "Enabled"

}


## Uploading Yaml File to Above Created S3 Bucket for each Conformance Pack

resource "aws_s3_object" "conformance_pack_template" {
  for_each = { for cp in var.conformancePacks : cp.ComplianceName => cp }

  bucket = module.ConformancePacke1_s3_bucket.bucket_id
  key    = each.value.filename
  source = "./Conformance_templates/${each.value.filename}"
  etag   = filemd5("./Conformance_templates/${each.value.filename}")
}


## Creating Conformance Pack for each entry

module "ConformancePack" {
  for_each = { for cp in var.conformancePacks : cp.ComplianceName => cp }

  source      = "./modules/ConformancePack"
  name        = each.value.ComplianceName
  bucketName  = var.ConformancePack1_bucketName
  templateKey = each.value.filename
  depends_on  = [aws_s3_object.conformance_pack_template]
}



