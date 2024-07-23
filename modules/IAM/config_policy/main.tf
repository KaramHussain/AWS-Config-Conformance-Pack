resource "aws_iam_policy" "config_policy" {
  name        = var.name
  path        = "/"
  description = "AWS Config permissions"

  policy = file("${path.module}/recorderPolicy.json")
}