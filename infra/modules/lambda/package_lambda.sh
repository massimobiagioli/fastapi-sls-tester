#!/bin/bash

# Package a lambda function
#
# Parameters:
#   $1: Lambda name
#   $2: Lambda source directory
#   $3: Build directory
#
# Example:
#   ./package_lambda.sh app_lambda ../../../../app ../../../../build/lambda

LAMBDA_ROOT_NAME='app'

cd "$(dirname "$0")"

printf "Packaging lambda $1\n"

rm -rf $3
mkdir -p $3
cp -R $2 $3/$LAMBDA_ROOT_NAME

cd $3/$LAMBDA_ROOT_NAME
rm -rf __pycache__/
rm *.pyc

# cd ..
# zip -r $1.zip .
# rm -rf $LAMBDA_ROOT_NAME

printf "Lambda $1 packaged\n"