locals {
  compatible_runtimes = ["python3.12"]
  bucket_prefix       = "layer"
  build_dir           = "${path.module}/../../../build/layer"
  pyproject_toml      = "${path.module}/../../../pyproject.toml"
  layer_path          = "${local.build_dir}/${var.name}.zip"
  layer_s3_key        = "${var.name}.zip"
}