#!/bin/bash
cd /root

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

#Install Go
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

#Install prerequisite packages
apt-get install -y docker-compose

# Clone PWD repo locally
git clone https://github.com/mateuszdrab/play-with-docker.git
cd play-with-docker

# Set correct branch
git checkout master

# Load the IPVS kernel module. Because swarms are created in dind,
# the daemon won't load it automatically
modprobe xt_ipvs

# Ensure Docker daemon is running in swarm mode
docker swarm init

# Get the latest franela/dind image
docker pull franela/dind

# Optional (with go1.14): pre-fetch module requirements into vendor
# so that no network requests are required within the containers.
# The module cache is retained in the pwd and l2 containers so the
# download is a one-off if you omit this step.
/.go/bin/go mod vendor

# Start PWD as a container
docker-compose up -d