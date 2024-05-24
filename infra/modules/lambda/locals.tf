locals {
  lambda_runtime = "python3.12"
  build_dir      = "${path.module}/../../../build/lambda"
  filename       = "${local.build_dir}/${var.function_name}.zip"
}