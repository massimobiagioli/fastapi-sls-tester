#!/bin/bash

# Package a layer for a Lambda function
#
# Parameters:
#   $1: Layer name
#   $2: Build directory
#
# Example:
#   ./package_layer.sh fastapi_layer ../../../../build/layer

cd "$(dirname "$0")"

layer_dir="$2/$1"
rm -rf $2
mkdir -p "$layer_dir"

requirements_file="$2/requirements.txt"
poetry export -f requirements.txt --output "$requirements_file" --without-hashes

printf "Packaging layer: $1\n"

pip install \
    --platform manylinux2014_x86_64 \
    --implementation cp \
    --only-binary=:all: \
    --upgrade \
    -r "$requirements_file" \
    -t "$layer_dir/python"

printf "Layer packaged: $1\n"
