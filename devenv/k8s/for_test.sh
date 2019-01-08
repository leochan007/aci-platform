#!/bin/bash

TMP_CMD=

if [ xt == x"$1" ]; then
    TMP_CMD=--insecure-skip-tls-verify=true
fi

echo 'TMP_CMD:'$TMP_CMD

kubectl config use-context acar-test-env

#kubectl $TMP_CMD create secret generic --from-env-file=envs/test/mongo-dev.env mongo-dev

#kubectl $TMP_CMD create secret generic --from-env-file=envs/test/mongo-express.env mongo-express

kubectl $TMP_CMD apply -f mongodb.yaml

kubectl $TMP_CMD apply -f mongo-express.yaml
