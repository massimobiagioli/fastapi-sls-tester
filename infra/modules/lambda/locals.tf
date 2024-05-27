locals {
  lambda_runtime   = "python3.12"
  build_dir        = "${path.module}/../../../build/lambda"
  filename         = "${local.build_dir}/${var.function_name}.zip"
  source_code_hash = fileexists(local.filename) ? filebase64sha256(local.filename) : null
  log_retention    = 14
}