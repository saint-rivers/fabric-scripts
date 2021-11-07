#!/bin/bash


# remove any pre-existing crypto materials
rm -rf ./crypto-config

# generate new crypto materials
cryptogen generate --config=${FABRIC_CFG_PATH}/crypto-config.yaml