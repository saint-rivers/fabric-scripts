#!/bin/bash

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

docker exec \
-e "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}" \
-e "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}" \
-e "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"  -it cli bash -c "./scripts/create-channel.sh"


# docker exec  -e "CORE_PEER_LOCALMSPID=SubwayMSP" \
# -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/fabric-samples/shelbys/crypto-config/peerOrganizations/subway.com/users/Admin@subway.com/msp" 
# -e "CORE_PEER_ADDRESS=peer0.subway.com:7051" -it cli bash -c "./scripts/create-channel.sh"
