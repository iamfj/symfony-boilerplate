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

DOCKER_COMPOSE="docker-compose -f ../../docker/docker-compose.yml -f ../../docker/docker-compose.${APP_ENV}.yml "
for file in $(ls ../../docker/apps/*/docker-compose.yml ../../docker/apps/*/docker-compose.$APP_ENV.yml); do
  DOCKER_COMPOSE="${DOCKER_COMPOSE}-f ${file} "
done

$DOCKER_COMPOSE run --rm "${APP_NAME}App" php -f "./bin/console" "${@}"
