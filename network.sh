#!/bin/bash

setEnvironment() {
        export PATH=$PATH:${PWD}/bin
        export FABRIC_CFG_PATH=${PWD}/config
}

networkSetup() {
        ./reset

        echo "======= Generating crypto materials ======="
        ./config/generate-crypto.sh
        echo "======= Generating artifacts ======="
        ./config/generate-artifacts.sh
}

networkUp() {
        echo "======= Starting orderer ======="
        ./config/start-orderer.sh
}

setEnvironment

if [ -z $1 ]; then
        echo "no arguments provided"
else
        if [ "$1" == "up" ]; then
                networkSetup
                networkUp
        else
                echo "umm"
        fi
fi
