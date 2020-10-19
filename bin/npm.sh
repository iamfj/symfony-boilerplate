#!/bin/bash

if [ ! -d "${PWD}/../../apps" ]; then
  echo "Error: Please execute this script from an app directory of your project!"
  exit 1;
fi

docker run --rm --interactive --tty \
  --volume "${PWD}:/app" \
  --volume "${NPM_HOME:-${HOME}/.npm}:/.npm" \
  --volume "${NPM_CONFIG:-${HOME}/.npm-config}:/.config" \
  --user "$(id -u):$(id -g)" \
  --workdir "/app" \
  node npm "${@}"
