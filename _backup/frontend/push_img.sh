#!/bin/bash

FLAG=testnet_stg

img_name=aci-frontend-stg

if [ x"testnet" == x"$1" ]; then
  FLAG=$1
  img_name=aci-frontend
fi

VER=`git rev-parse HEAD`
echo 'VER:'$VER
echo 'push '$img_name

docker push nexus.alphacario.com:8089/$img_name:v1
