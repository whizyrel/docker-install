#!/bin/bash

# https://docs.docker.com/engine/install/ubuntu/

set -e

readarray -td "=", PASS <<<"$1"; declare PASS;
PASSWORD=${PASS[1]}

if [ "$1" == '' ]
then
    echo 'No Root Password provided';
    exit 127
fi

echo $PASSWORD | sudo -S apt-get -y purge --remove docker-ce docker-ce-cli containerd.io

if [[ $2 == "--remove=true" ]]; then
  echo "Removing Docker Files"
  echo $PASSWORD | sudo -S rm -rf /var/lib/docker
  echo $PASSWORD | sudo -S rm -rf /var/lib/containerd
fi
