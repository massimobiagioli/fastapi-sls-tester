resource "null_resource" "package_lambda" {
  provisioner "local-exec" {
    command = "cd ${path.module} && ./package_lambda.sh ${var.function_name} ${var.source_dir} ${local.build_dir}"
  }
}

resource "aws_lambda_function" "app" {
  filename         = local.filename
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  layers           = var.layers
  runtime          = local.lambda_runtime
  source_code_hash = data.archive_file.lambda.output_base64sha256
  # environment {
  #   variables = {
  #     for pair in split("\n", var.secret_value) :
  #     split("=", pair)[0] => split("=", pair)[1]
  #   }
  # }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = local.log_retention
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-lambda-exec"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}