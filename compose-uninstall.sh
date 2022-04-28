#!/bin/bash

set -e

readarray -td "=", PASS <<<"$1"; declare PASS;
PASSWORD=${PASS[1]}
readarray -td "=", USR <<<"$2"; declare USR;
TRGT=${USR[1]}
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

if [ "$1" == '' ]
then
  echo 'No Root Password provided';
  exit 127
fi

if [ $TRGT == false ]; then
    DOCKER_CONFIG=/usr/local/lib/docker
fi

echo "Uninstalling docker compose"

if [ -z $(ls -la $DOCKER_CONFIG/cli-plugins/ | egrep compose | wc -l) ]; then
    DOCKER_CONFIG=/usr/local/lib/docker
fi

if [ $(ls -la $DOCKER_CONFIG/cli-plugins/ | egrep compose | wc -l) == 0 ]; then
    echo "No docker compose installed"
else
    echo $PASSWORD | sudo -S rm $DOCKER_CONFIG/cli-plugins/docker-compose
fi
