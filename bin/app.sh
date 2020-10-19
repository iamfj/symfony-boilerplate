#!/usr/bin/env bash
set -e

if [[ ! -f "${PWD}/bin/app.sh" ]]; then
  echo "Error: Please execute this script from your projects root!"
  exit 1
fi

export APP_ENV=${1}
if [[ "${APP_ENV}" != "" && ("${APP_ENV}" == "dev" || "${APP_ENV}" == "prod") ]]; then
  shift
else
  export APP_ENV=dev
fi

DOCKER_COMPOSE="docker-compose -f docker/docker-compose.yml -f docker/docker-compose.${APP_ENV}.yml "
for file in $(ls docker/apps/*/docker-compose.yml docker/apps/*/docker-compose.$APP_ENV.yml); do
  DOCKER_COMPOSE="${DOCKER_COMPOSE}-f ${file} "
done

$DOCKER_COMPOSE "${@}"
