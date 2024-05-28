locals {
  lambda_runtime = "python3.12"
  build_dir      = "${path.module}/../../../build/lambda"
  filename       = "${local.build_dir}/${var.function_name}.zip"
  dotenv_file    = "${path.module}/../../../.env.${var.stage}.local"
  log_retention  = 14
}