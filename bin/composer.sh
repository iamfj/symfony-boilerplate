#!/bin/bash

if [ ! -d "${PWD}/../../apps" ]; then
  echo "NO"
  exit 1;
fi

docker run --rm --interactive --tty \
  --volume "${PWD}:/app" \
  --volume "${COMPOSER_HOME:-${HOME}/.composer}:/tmp" \
  --user "$(id -u):$(id -g)" \
  composer "${@}"
