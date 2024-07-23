# resource "aws_config_configuration_recorder" "config_recorder" {
#   name     = "config-recorder"
#   role_arn = var.role_arn

#   recording_group {
#     all_supported                 = true
#     include_global_resource_types = true
#   }
# }

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "config-recorder"
  role_arn = var.role_arn

  recording_group {
    all_supported                 = false
    include_global_resource_types = false
    resource_types                = ["AWS::S3::Bucket"]
  }

  # lifecycle {
  #   ignore_changes = [
  #     recording_group,
  #     role_arn,
  #   ]
  # }
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = "config-delivery-channel"
  s3_bucket_name = var.s3_bucket_name

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.config_delivery_channel]
}

