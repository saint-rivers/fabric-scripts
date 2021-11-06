#!/bin/bash

# remove existing artifacts
rm -rf ./channel-artifacts
mkdir channel-artifacts

export CHANNEL_ID=mychannel 

# generate new artifacts
configtxgen -channelID system-channel -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/orderer.genesis.block


configtxgen -channelID ${CHANNEL_ID} -profile TwoOrgChannel -outputCreateChannelTx ./channel-artifacts/channel.tx


configtxgen -channelID ${CHANNEL_ID} -profile TwoOrgChannel -outputAnchorPeersUpdate ./channel-artifacts/KshrdMSPanchors.block -asOrg Kshrd
configtxgen -channelID ${CHANNEL_ID} -profile TwoOrgChannel -outputAnchorPeersUpdate ./channel-artifacts/SubwayMSPanchors.block -asOrg Subway