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

docker-compose \
  -f "${PWD}/docker/docker-compose.yml" \
  -f "${PWD}/docker/environments/docker-compose.${APP_ENV}.yml" "${@}"
