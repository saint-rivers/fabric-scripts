#!/bin/bash

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION=1
CC_SRC_PATH=${PWD}/chaincode
CC_NAME="mycc"

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


setupGoPackage() {
    pushd .. || exit
    go mod init sacc.go
    GO111MODULE=on go mod vendor
    go mod tidy
    popd || exit
}

packageChaincode(){
    pushd ./chaincode || exit
    rm -rf ${CC_NAME}.tar.gz 2> /dev/null
    setUpGlobalsForKshrd
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    popd || exit
    echo "======================== Chaincode packaged successfully ========================"
}

#  CORE_PEER_ADDRESS=peer0.kshrd.com peer lifecycle chaincode package mycc.tar.gz --path ./ --lang golang --label mycc_1

setupGoPackage
packageChaincode

