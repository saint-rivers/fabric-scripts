#!/bin/bash

echo COMPOSE_PROJECT_NAME=net > .env
docker-compose -f ./config/docker/docker-compose-cli.yaml up
# docker ps