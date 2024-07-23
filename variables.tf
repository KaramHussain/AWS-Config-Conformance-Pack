variable region {
    type = string
    description = "Region where to deploy"
    default = "us-east-1"
}

variable configRecorder_role_name {
    type = string
    description = "Name of the IAM role to be created"
    default = "config_role"
}

variable configRecorder_policy_name {
    type = string
    description = "Name of the IAM policy to be created"
    default = "config_policy"
}

variable config_results_bucket_name {
    type = string
    description = "Name of the S3 bucket to be created"
    default = "karam7790123"
}

variable conformance_pack_name {
    type = string
    description = "Name of the conformance pack to be created"
    default = "conformancepack"
}

variable conformance_pack_bucket_name {
    type = string
    description = "Name of the bucket to store the conformance pack results."
    default = "karam7790conformance"
}