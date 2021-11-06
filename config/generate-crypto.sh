#!/bin/bash


# remove any pre-existing crypto materials
rm -rf ./crypto-materials

# generate new crypto materials
cryptogen generate --config=${FABRIC_CFG_PATH}/crypto-config.yaml --output=./crypto-materials