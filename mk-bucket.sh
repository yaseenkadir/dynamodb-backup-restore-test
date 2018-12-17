#!/usr/bin/env bash

set -e
set -x

usage="Usage ./mk-bucket.sh <bucket name> <aws region> <aws profile (Optional)>"

if test $# -ne 2 && test $# -ne 3
then
    echo "$usage"
    exit 1
fi

bucket_name="$1"
aws_region="$2"
aws_profile="${3:-default}"

aws_cmd="aws --region $aws_region --profile $aws_profile"

echo "Creating bucket $bucket_name"
${aws_cmd} s3 mb "s3://$bucket_name"
