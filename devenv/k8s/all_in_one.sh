#!/bin/bash

FOLDER=test

TMP_CMD=

if [ -n "$1" ]; then
    FOLDER=$1
fi

if [ xt == x"$2" ]; then
    TMP_CMD=--insecure-skip-tls-verify=true
fi

if [ "prod" == "$FOLDER" ]; then
  echo 'set-context acar-credit-prod...'
  kubectl config use-context acar-credit-prod
  kubectl config use-context alphacar
else
  echo 'set-context acar-test-env...'
  kubectl config use-context acar-test-env
fi

kubectl config current-context

if [ xu == x"$3" ]; then
  ./update_envs.sh $FOLDER $2
fi

if [ "prod" == "$FOLDER" ]; then
  kubectl $TMP_CMD apply -f aci-backend.yaml
  #kubectl $TMP_CMD apply -f aci-demux-backend.yaml
  kubectl $TMP_CMD apply -f aci-blockchain-updater.yaml
  kubectl $TMP_CMD apply -f aci-frontend-ts.yaml
else
  ./for_test.sh $2
  kubectl $TMP_CMD apply -f aci-backend-stg.yaml
  #kubectl $TMP_CMD apply -f aci-demux-backend-stg.yaml
  kubectl $TMP_CMD apply -f aci-blockchain-updater-stg.yaml
  kubectl $TMP_CMD apply -f aci-frontend-ts-stg.yaml
fi

#kubectl apply -f aci-frontend-ts-stg.yaml
#kubectl apply -f aci-frontend-ts.yaml
