#!/bin/bash

# https://docs.docker.com/engine/install/ubuntu/

set -e

readarray -td "=", PASS <<<"$1"; declare PASS;
PASSWORD=${PASS[1]}
readarray -td "=", CLR <<<"$4"; declare CLR;
CLRFILE=${CLR[1]}

if [ "$1" == '' ]
then
  echo 'No Root Password provided';
  exit 127
fi

if [[ $2 == "--remove=true" ]]; then
  echo "Removing previous docker installation"

  # Remove older versions if any
  ./uninstall.sh "--password=$PASSWORD" "--remove=$CLRFILE"
fi

# Install using the repository
echo $PASSWORD | sudo -S apt-get update
echo $PASSWORD | sudo -S apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo $PASSWORD | sudo -S apt-get update
echo $PASSWORD | sudo -S apt-get install -y docker-ce docker-ce-cli containerd.io

# https://docs.docker.com/engine/install/linux-postinstall/

GRPEXISTS=$(cat /etc/group | grep docker | wc -l)

if [[ $GRPEXISTS == "0" ]];
then
  echo "Adding user to docker group"
  sudo groupadd docker
fi

sudo usermod -aG docker $USER
newgrp docker

if [[ $3 == "--test=true" ]]; then
  echo $PASSWORD | docker run hello-world
fi
