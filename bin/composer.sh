#!/bin/bash

if [ ! -d "${PWD}/../../apps" ]; then
  echo "Error: Please execute this script from an app directory of your project!"
  exit 1;
fi

docker run --rm --interactive --tty \
  --volume "${PWD}:/app" \
  --volume "${COMPOSER_HOME:-${HOME}/.composer}:/tmp" \
  --user "$(id -u):$(id -g)" \
  composer "${@}"
