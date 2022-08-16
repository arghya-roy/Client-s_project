#!/bin/bash
yum install curl -y
yum install unzip -y 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
mkdir ~/.aws
touch ~/.aws/config
echo "[default]
aws_access_key_id=AKIAS5TZESGVKPFJZFWY
aws_secret_access_key=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
region=ap-south-1
output=json" > ~/.aws/config

