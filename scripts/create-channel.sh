#!/bin/bash

export ORDERER_ADDRESS="localhost:7060"
export CHANNEL_NAME=mychannel
peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f /opt/gopath/fabric-samples/shelbys/channel-artifacts/channel.tx

# peer channel create -o localhost:7060 -c mychannel -f /opt/gopath/fabric-samples/shelbys/channel-artifacts/channel.tx


sleep 4s
peer channel join -b ./mychannel.block