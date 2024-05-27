locals {
  compatible_runtimes = ["python3.12"]
  bucket_prefix       = "layer"
  build_dir           = "${path.module}/../../../build/layer"
}