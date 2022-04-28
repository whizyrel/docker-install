#!/bin/bash

# https://docs.docker.com/compose/install/

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

echo $PASSWORD | sudo -S mkdir -p $DOCKER_CONFIG/cli-plugins

echo $(ls -la $DOCKER_CONFIG/cli-plugins/ | egrep compose | wc -l)
if [ $(ls -la $DOCKER_CONFIG/cli-plugins/ | egrep compose | wc -l) == 0 ]; then
    sudo -S curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
fi

sudo -S chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

docker compose version

exit 0
