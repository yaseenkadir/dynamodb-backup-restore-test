#!/usr/bin/env bash

set -e
set -x

usage="Usage ./create-keypair.sh <key pair name> <aws region> <aws profile (Optional)>"

if test $# -ne 2 && test $# -ne 3
then
    echo "$usage"
    exit 1
fi

key_pair_name="$1"
aws_region="$2"
aws_profile="${3:-default}"

aws_cmd="aws --region $aws_region --profile $aws_profile"

# https://www.dowdandassociates.com/blog/content/howto-create-an-amazon-ec2-key-pair-using-the-aws-cli/
echo "Creating keypair $key_pair_name"
${aws_cmd} ec2 create-key-pair --key-name "$key_pair_name" | jq -r ".KeyMaterial" > "$key_pair_name.pem"
