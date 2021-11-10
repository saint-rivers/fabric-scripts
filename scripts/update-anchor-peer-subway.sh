#!/bin/bash


# This script is only meant to be used inside the fabric-cli container

export ORDERER_ADDRESS="orderer.shelbys.com:7050"
export CHANNEL_NAME=mychannel 


echo "======= Updating anchor peers ======"
peer channel update -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f ./config/channel-artifacts/SubwayMSPanchors.block