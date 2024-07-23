variable name {
    description = "The name of the configuration recorder"
    type        = string
}

variable "role_arn" {
    description = "The ARN of the IAM role to be used by the configuration recorder will be passed by main.tf"
    type        = string
}

variable "bucketName" {
    description = "The name of the S3 bucket to be used by the configuration recorder will be passed by main.tf"
    type        = string
}