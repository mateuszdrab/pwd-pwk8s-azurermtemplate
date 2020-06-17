#!/bin/bash
mkdir -p /go/src/github.com/play-with-docker
cd /go/src/github.com/

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

#Install Go
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

#Install prerequisite packages
apt-get install -y docker-compose

# Clone PWD repo locally
cd play-with-docker
git clone https://github.com/mateuszdrab/play-with-docker.git
cd play-with-docker

# Load the IPVS kernel module. Because swarms are created in dind,
# the daemon won't load it automatically
modprobe xt_ipvs

# Ensure Docker daemon is running in swarm mode
docker swarm init

# Get the latest franela/dind image
docker pull franela/dind

# Set correct branch
if [ $1 == "k8s" ]; then
  git checkout -t "origin/$1"
fi

# Optional (with go1.14): pre-fetch module requirements into vendor
# so that no network requests are required within the containers.
# The module cache is retained in the pwd and l2 containers so the
# download is a one-off if you omit this step.
/.go/bin/go mod vendor

# Start PWD as a container
docker-compose up -d
