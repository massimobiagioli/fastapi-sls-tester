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

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = local.build_dir
  output_path = local.filename
  depends_on  = [null_resource.package_lambda]
}
