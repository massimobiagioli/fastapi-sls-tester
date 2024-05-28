data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "external" "lambda" {
  program = ["bash", "${path.module}/package_lambda.sh"]

  query = {
    name       = var.function_name
    source_dir = var.source_dir
    build_dir  = local.build_dir
    filename   = local.filename
  }
}