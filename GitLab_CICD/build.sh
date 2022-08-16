


#!/bin/sh
set -e

# Install some needed tools.
apk add gettext libintl

# setup aws credentials.
mkdir $HOME/.aws
envsubst < infrastructure/cloudformation/aws-credentials.base > $HOME/.aws/credentials


# Function to handle getting ssm parameters.
function fewsnet_parameter() {
  ENV_VALUE=$1

# Get our secrets.
aws --region $SERVICE_REGION ssm get-parameters \
  --name "$ENV_VALUE" \
  --with-decryption --query "Parameters[*].{Value:Value}" | jq .[] | jq ."Value" | sed -e 's/^"//' -e 's/"$//'
}

# Setup some needed variables.
FEWS_ENV=$1
FEWS_ENV_STRING=$(echo ${FEWS_ENV} | tr [a-z] [A-Z])

if [ $FEWS_ENV == "dev"  ]
then
  BUILD_ENV=develop
  SERVICE_REGION=us-east-2
  FDW_HOST_URL=https://fdwdev.fews.net
  # Copy the non-prod-robots.txt to public/robots.txt
  cp robots-text-files/non-prod-robots.txt public/robots.txt
elif [ $FEWS_ENV == "stage" ]
then
  BUILD_ENV=stage
  SERVICE_REGION=us-east-2
  FDW_HOST_URL=https://fdwstage.fews.net
  # Copy the non-prod-robots.txt to public/robots.txt
  cp robots-text-files/non-prod-robots.txt public/robots.txt
elif [ $FEWS_ENV == "demo" ]
then
  BUILD_ENV=demo
  SERVICE_REGION=us-east-2
  FDW_HOST_URL=https://fdwstage.fews.net
  # Copy the non-prod-robots.txt to public/robots.txt
  cp robots-text-files/non-prod-robots.txt public/robots.txt
elif [ $FEWS_ENV == "prod" ]
then
  BUILD_ENV=prod
  SERVICE_REGION=us-east-2
  FDW_HOST_URL=https://fdw.fews.net
  # Copy the prod-robots.txt into the public directory.
  cp robots-text-files/prod-robots.txt public/robots.txt
else
  echo "ERROR invalid ENV_VALUE"
exit 1
fi

# Log into ECR
$(aws ecr get-login --no-include-email --region ${SERVICE_REGION})

# Setup the variables we need for this environment.
# Load our variables from parameter store
export MYSQL_DATABASE=`fewsnet_parameter /FEWS/${FEWS_ENV_STRING}/DB_DATABASE`
export MYSQL_USER=`fewsnet_parameter /FEWS/${FEWS_ENV_STRING}/DB_USERNAME`
export MYSQL_PASSWORD=`fewsnet_parameter /FEWS/${FEWS_ENV_STRING}/DB_PASSWORD`
export MYSQL_HOST=`fewsnet_parameter /FEWS/${FEWS_ENV_STRING}/DB_HOST`
export REDIS_HOST=`fewsnet_parameter /FEWS/${FEWS_ENV_STRING}/REDIS_HOST`
export FDW_HOST=${FDW_HOST_URL}

# Create our current.env file.
envsubst < .gitlab-ci/current.env.base > current.env
 
# Copy Dockerfile into toplevel.
cp .gitlab-ci/Dockerfile Dockerfile

# Build our docker image.
docker build \
  --build-arg dbname=${MYSQL_DATABASE} \
  --build-arg dbuser=${MYSQL_USER} \
  --build-arg dbpass=${MYSQL_PASSWORD} \
  --build-arg dbhost=${MYSQL_HOST} \
  --build-arg redis_host=${REDIS_HOST} \
  --build-arg fdw_host=${FDW_HOST} \
  -t $REPOSITORY_URL:${BUILD_ENV}-${CI_COMMIT_SHA} .

# Pushed the container to ECR.
docker push $REPOSITORY_URL:${BUILD_ENV}-${CI_COMMIT_SHA}

# TODO update /FEWS/[FEWS_ENV]/LAST_DEPLOY_HASH
