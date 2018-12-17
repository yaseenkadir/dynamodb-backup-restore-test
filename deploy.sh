#!/usr/bin/env bash

set -e
set -x

usage="Usage ./deploy.sh <app s3 bucket> <keypair name> <aws region> <aws profile (Optional)>"

if test $# -ne 3 && test $# -ne 4
then
    echo "$usage"
    exit 1
fi

app_bucket="$1"
keypair_name="$2"
aws_region="$3"
aws_profile="${4:-default}"

aws_cmd="aws --region $aws_region --profile $aws_profile"

echo "Deploying stack"
${aws_cmd} cloudformation deploy \
    --template-file "cloudformation.yml" \
    --stack-name test-dynamodb-stack \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
    KeyName="$keypair_name"
#    AppS3Bucket="$app_bucket"
