#!/bin/bash

apt purge -y nodejs nodejs-legacy npm

./nodesource_setup.sh

apt install -y nodejs

npm i -g yarn
