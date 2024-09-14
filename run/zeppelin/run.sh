#!/bin/bash
set -ex
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $BASE/../base.sh
CUR_DATA_DIR=$DATA_DIR/$(basename $BASE)
VERSION=0.10.1
NAME=ctn-zeppelin

# prepare data directory
mkdir -p $CUR_DATA_DIR/logs
mkdir -p $CUR_DATA_DIR/notebook

function create() {
  docker run -d --restart=always -p 8080:8080 \
    -v $CUR_DATA_DIR/logs:/logs \
    -v $CUR_DATA_DIR/notebook:/notebook \
    -v /data:/data \
    -e ZEPPELIN_LOG_DIR='/logs' \
    -e ZEPPELIN_NOTEBOOK_DIR='/notebook' \
    --name $NAME apache/zeppelin:$VERSION
}

function delete() {
  docker stop $NAME
  docker rm $NAME
}

if [ "$1" == "" ]; then
  create
else
  eval $1
fi