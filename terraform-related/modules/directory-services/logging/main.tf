resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/directoryservice/${var.region_name}/${var.directory_id}"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

data "aws_iam_policy_document" "ad_log_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    principals {
      identifiers = ["ds.amazonaws.com"]
      type        = "Service"
    }

    resources = ["${aws_cloudwatch_log_group.this.arn}:*"]

    effect = "Allow"
  }
}

resource "aws_cloudwatch_log_resource_policy" "ad_log_policy" {
  policy_document = data.aws_iam_policy_document.ad_log_policy.json
  policy_name     = "${var.directory_id}_${var.region_name}_ad_log_policy"
}

resource "aws_directory_service_log_subscription" "this" {
  directory_id   = var.directory_id
  log_group_name = aws_cloudwatch_log_group.this.name
}

