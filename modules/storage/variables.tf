# Name of the Bucket
variable bucket_name {
    description = "The name of the S3 bucket to store AWS Config conformance pack delivery channel data."
    type        = string
}


# To see if the Bucket is verisoned or not
variable VersionStatus {
    description = "Enable versioning for the S3 bucket."
    type        = string
}