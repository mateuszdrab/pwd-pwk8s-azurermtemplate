#!/bin/bash
cd /root

# Load the IPVS kernel module. Because swarms are created in dind,
# the daemon won't load it automatically
modprobe xt_ipvs

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

#Install docker-compose
apt-get install -y docker-compose

# Ensure Docker daemon is running in swarm mode
docker swarm init

# Get the latest franela images
docker pull franela/dind
docker pull franela/k8s

#Install Go
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

# Clone PWD repo locally
git clone https://github.com/mateuszdrab/play-with-docker.git
cd play-with-docker

# Optional (with go1.14): pre-fetch module requirements into vendor
# so that no network requests are required within the containers.
# The module cache is retained in the pwd and l2 containers so the
# download is a one-off if you omit this step.
bash -c '/.go/bin/go mod vendor' > /var/log/go.log 2>&1

# Set correct branch
if [ $1 == "k8s" ]; then
  mv www/default www/docker
  mv www/k8s www/default
fi

# Start PWD as a container
docker-compose up -d
