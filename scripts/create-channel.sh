#!/bin/bash


# This script is only meant to be used inside the fabric-cli container

export ORDERER_ADDRESS="orderer.shelbys.com:7050"
export CHANNEL_NAME=mychannel
# peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f /opt/gopath/fabric-samples/shelbys/channel-artifacts/channel.tx
echo "======= Creating a new channel ======"
peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f ./config/channel-artifacts/channel.tx --outputBlock ./config/channel-artifacts/${CHANNEL_NAME}.block

echo "======= Confirm created channel ======"
peer channel list

# peer channel create -o localhost:7050 -c mychannel -f /opt/gopath/fabric-samples/shelbys/channel-artifacts/channel.tx

sleep 4s
echo "======= Joining the new channel ======"
peer channel join -b ./config/channel-artifacts/mychannel.block 
