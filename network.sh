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
        docker-compose -f ./config/docker/docker-compose-cli.yaml down 2>/dev/null
}

deployChaincode() {
        echo "======= Deploying chaincode ======="
        ./chaincode/scripts/setup-chaincode.sh
        ./chaincode/scripts/deploy-chaincode.sh
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
        ./network.sh down && ./network.sh up && ./network.sh channel && ./network.sh deployCC
else
        case "$1" in
        "up")
                networkSetup && networkUp
                ;;
        "down")
                networkDown
                ./reset.sh 2>/dev/null
                ;;
        "channel")
                ./login-fabric-cli.sh
                ;;
        "deployCC")
                deployChaincode
                ;;
        esac
fi
