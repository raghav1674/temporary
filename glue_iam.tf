data "aws_iam_policy" "glue_service_role_policy" {
    name = "AWSGlueServiceRole"
}

data "aws_iam_policy_document" "glue_assume_role_policy" {
    statement {
      actions = ["sts:AssumeRole"]
  
      principals {
        type        = "Service"
        identifiers = ["glue.amazonaws.com"]
      }
    }
}

resource "aws_iam_role" "glue_role" {
    name                = "test_glue_role"
    assume_role_policy  = data.aws_iam_policy_document.glue_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "glue_role_policy" {
    role       = aws_iam_role.glue_role.name 
    policy_arn = data.aws_iam_policy.glue_service_role_policy.arn
}
