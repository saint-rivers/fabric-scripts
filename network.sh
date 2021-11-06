#!/bin/bash

setEnvironment() {
        export PATH=$PATH:${PWD}/bin
        export FABRIC_CFG_PATH=${PWD}/config
}

reset(){
        echo "======= Resetting configurations ======="
        killall peer
        killall orderer
        rm -rf channel-artifacts
        rm -rf crypto-materials
}

generateCertificates() {
        echo "======= Generating crypto materials ======="
        ./config/generate-crypto.sh
}

generateArtifacts() {
        echo "======= Generating artifacts ======="
        ./config/generate-artifacts.sh
}

setEnvironment

if [ -z $1 ]; then
        echo "no arguments provided"
else
        if [ "$1" == "up" ]; then
                reset
                generateCertificates
                generateArtifacts
        else
                echo "umm"
        fi
fi
