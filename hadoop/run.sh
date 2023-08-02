#!/bin/bash
set -ex
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $BASE/../base.sh
CUR_DATA_DIR=$DATA_DIR/$(basename $BASE)
COMPOSE_FILE=$BASE/docker-compose.yaml

function create() {
    docker-compose up -d -f $COMPOSE_FILE
}

function down() {
    docker-compose down -f $COMPOSE_FILE
}

if [ "$1" == "" ]; then
  create
else
  eval $1
fi