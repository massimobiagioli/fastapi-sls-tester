resource "null_resource" "package_lambda" {
  provisioner "local-exec" {
    command = "cd ${path.module} && ./package_lambda.sh ${var.function_name} ${var.source_dir} ${local.build_dir}"
  }
}

resource "aws_lambda_function" "app" {
  filename      = local.filename
  function_name = var.function_name
  role          = aws_iam_role.lambda_exec.arn
  depends_on    = [null_resource.package_lambda]
  handler       = var.handler
  layers        = var.layers
  runtime       = local.lambda_runtime
  # environment {
  #   variables = {
  #     for pair in split("\n", var.secret_value) :
  #     split("=", pair)[0] => split("=", pair)[1]
  #   }
  # }

  tags = var.tags
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