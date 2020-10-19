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

docker-compose \
  -f "${PWD}/../../docker/docker-compose.yml" \
  -f "${PWD}/../../docker/environments/docker-compose.${APP_ENV}.yml" \
  run --rm "${APP_NAME}" php -f "./bin/console" "${@}"
