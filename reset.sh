#!/bin/bash

reset() {
        echo "======= Resetting configurations ======="
        killall peer
        killall orderer
        rm -rf channel-artifacts
        rm -rf crypto-config
        sudo rm -rf production
        # rm -rf scripts
        rm -rf chaincode

        rm mychannel.block
        # docker container rm cli peer0.kshrd.com peer0.subway.com orderer.shelbys.com
        ./clear-containers.sh
}

reset