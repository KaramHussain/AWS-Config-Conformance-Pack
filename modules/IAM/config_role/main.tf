resource "aws_iam_role" "config_role" {
  name = var.name
  assume_role_policy = file("${path.module}/recorderRole.json")
}