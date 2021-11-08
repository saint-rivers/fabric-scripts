#!/bin/bash

setEnvironment() {
        export PATH=$PATH:${PWD}/bin
        export FABRIC_CFG_PATH=${PWD}/config
}

networkSetup() {
        ./reset.sh
        ./clear-containers.sh

        echo "======= Generating crypto materials ======="
        ./config/generate-crypto.sh
        echo "======= Generating artifacts ======="
        ./config/generate-artifacts.sh
}

networkUp() {
        echo "======= Starting network ======="
        echo COMPOSE_PROJECT_NAME=net >.env
        docker-compose -f ./config/docker/docker-compose-cli.yaml up -d
}

networkDown() {
        echo "======= Stopping network ======="
        echo COMPOSE_PROJECT_NAME=net >.env
        docker-compose -f ./config/docker/docker-compose-cli.yaml down
}

# createChannel() {
#         # export ORDERER_ADDRESS="localhost:7050"
#         # export CHANNEL_NAME=mychannel
#         # peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f ./channel-artifacts/channel.tx

#         # sleep 4s
#         # peer channel join -b ./mychannel.block
# }

setEnvironment

if [ -z $1 ]; then
        echo "no arguments provided"
else
        case "$1" in
        "up")
                networkSetup && networkUp
                ;;
        "down")
                networkDown
                ./reset.sh
                ;;
        "channel")
                ./login-fabric-cli.sh
                # ./scripts/create-channel.sh
                ;;
        esac
fi
