#!/bin/bash

FLAG=testnet_stg

if [ -n "$1" ]; then
  FLAG=$1
fi

VER=`git rev-parse HEAD`

echo 'VER:'$VER

rm -rf dist && npm i && TESTNET=$FLAG npm run build

img_name=aci-frontend-stg

if [ "testnet" == "$FLAG" ]; then
  img_name=aci-frontend
fi

docker build -t $img_name .

docker tag $img_name:latest nexus.alphacario.com:8089/$img_name:v1

docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)

docker images |grep none |awk -F ' ' '{print $3}'|xargs docker rmi

#docker push nexus.alphacario.com:8089/aci-frontend:v1
