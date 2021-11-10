#!/bin/bash

export FABRIC_CFG_PATH=${PWD}/config

setUpGlobalsForKshrd() {
    export CORE_PEER_LOCALMSPID=KshrdMSP
    export CORE_PEER_MSPCONFIGPATH=/opt/gopath/fabric-samples/shelbys/crypto-config/peerOrganizations/kshrd.com/users/Admin@kshrd.com/msp
    export CORE_PEER_ADDRESS=peer0.kshrd.com:7051
}

setUpGlobalsForSubway() {
    export CORE_PEER_LOCALMSPID=SubwayMSP
    export CORE_PEER_MSPCONFIGPATH=/opt/gopath/fabric-samples/shelbys/crypto-config/peerOrganizations/subway.com/users/Admin@subway.com/msp
    export CORE_PEER_ADDRESS=peer0.subway.com:7051
}


setUpGlobalsForKshrd

# deploy chaincode
docker exec \
-e "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}" \
-e "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}" \
-e "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}" -it cli bash -c "./scripts/chaincode/deploy.sh"


setUpGlobalsForSubway

docker exec \
-e "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}" \
-e "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}" \
-e "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}" -it cli bash -c "./scripts/chaincode/deploy.sh"