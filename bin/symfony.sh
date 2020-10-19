#!/bin/bash

if [ ! -d "${PWD}/../../apps" ]; then
  echo "Error: Please execute this script from an app directory of your project!"
  exit 1;
fi

# Important: The app directory name should match the container name.
APP_NAME=$(basename $(dirname "${PWD}/*"))
APP_ENV=${1}
if [[ "${APP_ENV}" != "" && ("${APP_ENV}" == "dev" || "${APP_ENV}" == "prod") ]]; then
  shift
else
  export APP_ENV=dev
fi

docker exec -it "${APP_NAME}_${APP_ENV}_php" php -f "../apps/${APP_NAME}/bin/console" "${@}"
