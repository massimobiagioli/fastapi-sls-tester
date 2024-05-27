locals {
  compatible_runtimes = ["python3.12"]
  bucket_prefix       = "layer"
  build_dir           = "${path.module}/../../../build/layer"  
  filename            = "${local.build_dir}/${var.name}.zip"
  layer_s3_key        = "${var.name}.zip"
}