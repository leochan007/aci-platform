#!/bin/bash

set -x
set -e

mode=run
data_dir=/root/data
config_dir=/root/config
mongo_url=mongo://root:example@127.0.0.1:27017/EOS

mongodb_store_blocks=false
mongodb_store_block_states=false
mongodb_store_transactions=false
mongodb_store_transaction_traces=false

mongodb_store_action_traces=true
mongodb_filter_on=*
mongodb_block_start=1

if [ -n "$MODE" ]; then
  mode=$MODE
fi

if [ -n "$DATA_DIR" ]; then
  data_dir=$DATA_DIR
fi

if [ -n "$CONFIG_DIR" ]; then
  config_dir=$CONFIG_DIR
fi

if [ -n "$MONGO_URL" ]; then
  mongo_url=$MONGO_URL
fi

if [ -n "$BLOCK_START" ]; then
  mongodb_store_blocks=$BLOCK_START
fi

if [ -n "$STORE_BLOCKS" ]; then
  mongodb_store_blocks=$STORE_BLOCKS
fi

if [ _n "$STORE_BLOCK_STATES" ]; then
  mongodb_store_block_states=$STORE_BLOCK_STATES
fi

if [ -n "$STORE_TRANSACTIONS" ]; then
  mongodb_store_transactions=$STORE_TRANSACTIONS
fi

if [ -n "$STORE_TRANSACTIONS_TRACES" ]; then
  mongodb_store_transaction_traces=$STORE_TRANSACTIONS_TRACES
fi

if [ -n "$FILTER_ON" ]; then
  mongodb_filter_on=$FILTER_ON
fi

mongo_plugin_opt="--mongodb-block-start=$mongodb_block_start \
    --mongodb-store-blocks=$mongodb_store_blocks \
    --mongodb-store-block-states=$mongodb_store_block_states \
    --mongodb-store-transactions=$mongodb_store_transactions \
    --mongodb-store-transaction-traces=$mongodb_store_transaction_traces \
    --mongodb-filter-on=$mongodb_filter_on"

echo 'MODE:'$mode
echo 'DATA_DIR:'$data_dir
echo 'CONFIG_DIR:'$config_dir
echo 'MONGO_URL:'$mongo_url

if [ "init" == "$mode" ]; then
  /usr/bin/nodeos \
  --genesis-json=$config_dir/genesis.json \
    --data-dir=$data_dir \
    --config-dir=$config_dir \
    --delete-all-blocks \
    --mongodb-wipe \
    $mongo_plugin_opt \
    --mongodb-uri=$mongo_url
elif [ "replay" == "$mode" ]; then
  /usr/bin/nodeos \
  --genesis-json=$config_dir/genesis.json \
    --data-dir=$data_dir \
    --config-dir=$config_dir \
    --replay-blockchain \
    --hard-replay-blockchain \
    $mongo_plugin_opt \
    --mongodb-uri=$mongo_url
elif [ "run" == "$mode" ]; then
  /usr/bin/nodeos \
  --genesis-json=$config_dir/genesis.json \
    --data-dir=$data_dir \
    --config-dir=$config_dir \
    $mongo_plugin_opt \
    --mongodb-uri=$mongo_url
fi
