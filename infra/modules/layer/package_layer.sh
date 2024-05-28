#!/bin/bash

# Package a layer for a Lambda function
#
# Parameters:
#   $layer_name: Layer name
#   $build_dir: Build directory
#   $filename: Output filename
#
# Example:
#   ./package_layer.sh fastapi_layer ../../../../build/layer fastapi_layer.zip

set -e

eval "$(jq -r '@sh "layer_name=\(.layer_name) build_dir=\(.build_dir) filename=\(.filename)"')"

cd "$(dirname "$0")"

layer_dir="$build_dir/$layer_name"
rm -rf $build_dir
mkdir -p "$layer_dir"

requirements_file="$build_dir/requirements.txt"
poetry export -f requirements.txt --output "$requirements_file" --without-hashes --quiet

pip install \
    --platform manylinux2014_x86_64 \
    --implementation cp \
    --only-binary=:all: \
    --upgrade \
    -r "$requirements_file" \
    -t "$layer_dir/python" \
    -q

cd "$layer_dir"
zip -r "$layer_name.zip" . -q
mv "$layer_name.zip" "../$layer_name.zip"
rm -rf "../$layer_name"
rm "../requirements.txt"

jq -n --arg filename "$filename" '{"filename":$filename}'