provider "aws" {
  region = var.region
}

module "config_policy" {
  source = "./modules/IAM/config_policy"
  name = var.configRecorder_policy_name
}

module "config_role" {
  source = "./modules/IAM/config_role"
  name = var.configRecorder_role_name
}

resource "aws_iam_role_policy_attachment" "config_policy_attachment" {
  role       = var.configRecorder_role_name
  policy_arn = module.config_policy.aws_config_service_policy_arn
}


module "recorder" {
  source = "./modules/recorder"
  role_arn = module.config_role.config_role_arn
  s3_bucket_name = var.config_results_bucket_name
}


# module "conformance_pack_bucket" {
#   source = "./modules/storage/conformance_pack_storage"
#   bucketname = var.conformance_pack_bucket_name
# }


module "conformance_pack_storage" {
  source = "./modules/storage/conformace_pack_storage"
  bucketname = var.conformance_pack_bucket_name
}


