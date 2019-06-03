#!/bin/bash

FOLDER=test

TMP_CMD=

NS='--namespace eos-dapp'

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
  NS=''
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
    kubectl $TMP_CMD delete configmap $name $NS
    kubectl $TMP_CMD create configmap $name --from-env-file=$item $NS
  fi
  if echo $name|grep -qe '^secret-' ;then
    echo 'get secret:' $name
    kubectl $TMP_CMD delete secret $name $NS
    kubectl $TMP_CMD create secret generic --from-env-file=$item $name $NS
  fi
done
