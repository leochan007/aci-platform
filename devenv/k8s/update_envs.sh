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
else
  echo 'set-context acar-test-env...'
  kubectl config use-context acar-test-env
fi

for item in `ls ./envs/$FOLDER/*.env`
do
  tmp=${item##*/}
  name=${tmp%.*}
  if echo $name|grep -qe '^configmap-' ;then
    echo 'get configmap:' $name
    kubectl $TMP_CMD delete configmap $name --namespace eos-dapp
    kubectl $TMP_CMD create configmap $name --from-env-file=$item --namespace eos-dapp
  fi
  if echo $name|grep -qe '^secret-' ;then
    echo 'get secret:' $name
    kubectl $TMP_CMD delete secret $name --namespace eos-dapp
    kubectl $TMP_CMD create secret generic --from-env-file=$item $name --namespace eos-dapp
  fi
done
