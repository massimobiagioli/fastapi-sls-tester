data "archive_file" "layer" {
  type        = "zip"
  source_dir  = local.layer_dir
  output_path = local.filename
  depends_on  = [null_resource.package_layer]
}