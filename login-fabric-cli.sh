#!/bin/bash

docker exec \
-e "CORE_PEER_LOCALMSPID=KshrdMSP" \
-e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/fabric-samples/shelbys/crypto-config/peerOrganizations/kshrd.com/users/Admin@kshrd.com/msp" \
-e "CORE_PEER_ADDRESS=peer0.kshrd.com:7051"  -it cli bash -c "./scripts/create-channel.sh"