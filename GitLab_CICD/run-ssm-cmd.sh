


#!/bin/sh
# Helper function.

# Install some needed tools.
apk add gettext libintl

# setup aws credentials.
mkdir $HOME/.aws
envsubst < infrastructure/cloudformation/aws-credentials.base > $HOME/.aws/credentials

function usage() {
  echo -e "usage:      ${0} environment [develop|stage|demo|prod]\n"
}

# Ensure we have our Build environment variable set.
if [[ -z "${1// }" ]]; then
  echo "ERROR: Build environment not set."
  usage
  exit 1
fi

SITE_ENV=$1

# Debug AWS setup: Whoami
aws --profile=default --region=us-east-2 sts get-caller-identity
infrastructure/extras/fewsadm/run-ssm-cmd updates --environment $SITE_ENV --profile default
