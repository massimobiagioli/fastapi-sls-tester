resource "null_resource" "package_layers" {
  triggers = {
    hash_poetry = sha1(local.pyproject_toml)
  }

  provisioner "local-exec" {
    command = "cd ${path.module} && ./package_layer.sh ${var.name} ${local.build_dir}"
  }
}

resource "aws_s3_bucket" "layer" {
  bucket_prefix = local.bucket_prefix

  tags = var.tags
}

resource "aws_s3_object" "layer_zip" {
  bucket      = aws_s3_bucket.layer.id
  key         = local.layer_s3_key
  source      = local.layer_path
  depends_on  = [null_resource.package_layers]

  tags = var.tags
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_bucket           = aws_s3_bucket.layer.id
  s3_key              = aws_s3_object.layer_zip.key
  layer_name          = var.name
  compatible_runtimes = local.compatible_runtimes
  description         = var.description
  skip_destroy        = true
  depends_on          = [aws_s3_object.layer_zip]
  source_code_hash    = filebase64sha256(local.layer_path)
}