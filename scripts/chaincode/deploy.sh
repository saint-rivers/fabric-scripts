#!/bin/bash

export CHANNEL_NAME="mychannel"
export CC_RUNTIME_LANGUAGE="golang"
export VERSION=1
export CC_SRC_PATH=${PWD}/config/chaincode
export CC_NAME="mycc"
export ORDERER_ADDRESS="orderer.shelbys.com:7050"

# ====================================================================
#                       package chaincode
# ====================================================================

rm -rf ${CC_NAME}.tar.gz 2>/dev/null

peer lifecycle chaincode package ${CC_NAME}.tar.gz \
    --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
    --label ${CC_NAME}_${VERSION}
echo "======================== Chaincode packaged successfully ========================"

# ====================================================================
#                       install chaincode
# ====================================================================

peer lifecycle chaincode install ${CC_NAME}.tar.gz
echo "======================== Installed chaincode on ${CORE_PEER_ADDRESS} ========================"

# ====================================================================
#                       install chaincode
# ====================================================================

peer lifecycle chaincode queryinstalled >&log.txt
cat log.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//;p;}" log.txt)

peer lifecycle chaincode approveformyorg -o ${ORDERER_ADDRESS} \
    --channelID ${CHANNEL_NAME} --name ${CC_NAME} --version ${VERSION} \
    --init-required --package-id "$PACKAGE_ID" --sequence ${VERSION}

echo "======================== Installation approved for ${CORE_PEER_ADDRESS} ========================"

# peer chaincode list --installed