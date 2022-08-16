

#!/bin/sh

set -ex

export PATH="$PATH:$(pwd)/infrastructure/cloudformation/ecs-deploy/linux/"

# Helper function.
function usage() {
  echo -e "usage:      ${0} environment [develop|stage|demo|prod]\n"
}

# Ensure we have our Build environment variable set.
if [[ -z "${1// }" ]]; then
  echo "ERROR: Build environment not set."
  usage
  exit 1
fi

# Install some needed tools.
apk add gettext libintl

BUILD_ENV=$1
if [ $BUILD_ENV == "develop" ]
then
	SERVICE_ENV=dev
	STACK=fewsnet-develop-svc
  SERVICE_REGION=us-east-2
elif [ $BUILD_ENV == "stage" ]
then
	SERVICE_ENV=stage
	STACK=fewsnet-stage-svc
  SERVICE_REGION=us-east-2
elif [ $BUILD_ENV == "demo" ]
then
	SERVICE_ENV=demo
	STACK=fewsnet-demo-svc
  SERVICE_REGION=us-east-2
elif [ $BUILD_ENV == "prod" ]
then
	SERVICE_ENV=prod
	STACK=fewsnet-prod-svc
  SERVICE_REGION=us-east-2
else
  echo "ERROR invalid BUILD_ENV"
  exit 1
fi

cd infrastructure/cloudformation
export BUILD_IMAGE_TAG=${BUILD_ENV}-${CI_COMMIT_SHA}

# setup aws credentials.
mkdir $HOME/.aws
envsubst < aws-credentials.base > $HOME/.aws/credentials

# Substitute environment variables.
envsubst < ${BUILD_ENV}-service-config.yaml.base > ${BUILD_ENV}-service-config.yaml

# Debug.
cat ${BUILD_ENV}-service-config.yaml

# Perform deployment.
ecs-deploy service --aws-profile=default \
  --region=${SERVICE_REGION} \
  --service-env=${SERVICE_ENV} \
  --stack-cmd=update-stack \
  --stack-name=fewsnet-${BUILD_ENV}-svc \
  --config=${BUILD_ENV}-service-config.yaml

echo "Stack ${STACK} is updating will continue when update is complete..."

aws --profile=default --region ${SERVICE_REGION} cloudformation wait stack-update-complete --stack-name ${STACK}

echo "The ${STACK} update completed..."
