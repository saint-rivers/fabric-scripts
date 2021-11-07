#!/bin/bash

echo "======= Stopping containers ======="
# docker container stop cli peer0.kshrd.com peer0.subway.com orderer.shelbys.com 2> /dev/null
docker-compose -f ./config/docker/docker-compose-cli.yaml down

echo "======= Removing containers ======="
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
# docker system prune -a

echo "======= Associated containers have been cleared ======="