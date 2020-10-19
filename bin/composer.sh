#!/bin/bash

if [ ! -d "${PWD}/../../apps" ]; then
  echo "Error: Please execute this script from an app directory of your project!"
  exit 1;
fi

APP_NAME=$(basename $(dirname "${PWD}/*"))
ENV_FILE=""

if [[ -f "${PWD}/../../environment/dev/apps/${APP_NAME}.app.env" ]]; then
  ENV_FILE="--env-file ${PWD}/../../environment/dev/apps/${APP_NAME}.app.env"
fi

docker run --rm --interactive --tty \
  --volume "${PWD}:/app" \
  --volume "${COMPOSER_HOME:-${HOME}/.composer}:/tmp" \
  --user "$(id -u):$(id -g)" \
  $ENV_FILE \
  composer "${@}"
