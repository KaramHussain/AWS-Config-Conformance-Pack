variable "region" {
  type        = string
  description = "Region where to deploy"
  default     = "us-east-2"
}

variable "configRecorder_role_name" {
  type        = string
  description = "Name of the IAM role to be created"
  default     = "config_role"
}

variable "configRecorder_policy_name" {
  type        = string
  description = "Name of the IAM policy to be created"
  default     = "config_policy"
}

variable "RecorderBucketName" {
  type        = string
  description = "Name of the S3 bucket to be created"
  default     = "karam7790123"
}


variable "configRecorder_name" {
  type        = string
  description = "Name of the AWS Config Recorder to be created"
  default     = "config_recorder"
}

variable "ConformancePack1_bucketName" {
  type        = string
  description = "Name of the bucket to store the conformance pack results."
  default     = "karam7790conformance"
}

variable "ConformanceName" {
  type        = string
  description = "Name of the conformance pack to be created"
  default     = "conformancepack"
}


variable "conformancePacks" {
  description = "List of conformance packs with their filenames and compliance names"
  type        = list(map(string))
  default = [
    {
      filename       = "dynamodb.yaml",
      ComplianceName = "dynamodbComplaince"
    },
    {
      filename       = "EC2BestPractices.yaml",
      ComplianceName = "EC2BestPractices"
    }
    // Add more conformance packs as needed
  ]
}