

#!/bin/sh

# Install some needed tools.
apk add gettext libintl

configure_covid_visualization() {
	FEWS_ENV=$1
	if [ $FEWS_ENV == "dev"  ]
	then
		FDW_HOST_URL=https://fdwdev.fews.net
	elif [ $FEWS_ENV == "stage" ]
	then
		FDW_HOST_URL=https://fdwstage.fews.net
	elif [ $FEWS_ENV == "demo" ]
	then
		FDW_HOST_URL=https://fdwstage.fews.net
	elif [ $FEWS_ENV == "prod" ]
	then
		FDW_HOST_URL=https://fdw.fews.net
	else
		echo "ERROR invalid ENV_VALUE"
	exit 1
	fi

  # Build the visualizations.
  echo "change into visualization directory"
  cd public/sites/all/modules/custom/fewsnet_covid_visualizations

  echo "Run docker command to build visualization"

  docker run --rm -w /app -v $(pwd)/:/app node:10.21.0-jessie yarn install --frozen-lockfile
  docker run --rm -w /app -v $(pwd)/:/app node:10.21.0-jessie yarn build

  # Copy template file into build directory.
  echo "Copying template file to build folder"

  # Create covid19page.tpl.php template file.
  export CSS_CHUNK=$(find ./build/ -name "*chunk.css" -print | sed 's/\.\/build\/static\/css\///g')
  export JS_CHUNK_2=$(find ./build/ -name "*chunk.js" -print | sed 's/\.\/build\/static\/js\///g' | grep -v main)
  export JS_CHUNK_MAIN=$(find ./build/ -name "*chunk.js" -print | sed 's/\.\/build\/static\/js\///g' | grep main)
  export FDW_HOST=$FDW_HOST_URL
  envsubst < /builds/fewsnet/web/fewsnet/.gitlab-ci/covid19page.tpl.php.input > build/covid19page.tpl.php

  # Create a Version file so it is easier to debug.
  cat <<EOF > build/CURRENT_VERSION
  $COVID_WIDGET_VERSION
EOF
}

BUILD_ENV=$1
configure_covid_visualization $BUILD_ENV
