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
        echo "======= Starting orderer ======="
        ./config/start-network.sh
}

createChannel() {
        export ORDERER_ADDRESS="localhost:7060"
        export CHANNEL_NAME=mychannel
        peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f ./channel-artifacts/channel.tx

        sleep 4s
        peer channel join -b ./mychannel.block
}

setEnvironment

if [ -z $1 ]; then
        echo "no arguments provided"
else
        if [ "$1" == "up" ]; then
                networkSetup
                networkUp
        fi
fi

if [ "$1" == "channel" ]; then
        createChannel
fi

