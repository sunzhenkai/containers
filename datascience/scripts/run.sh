#!/bin/bash
set -e
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $BASE/../../scripts/base.sh
CUR_DATA_DIR=$DATA_DIR/$(basename $BASE)
COMPOSE_FILE=$BASE/../$ENV.yml

function create() {
  docker compose up -d -f $COMPOSE_FILE
}

function start() {
  docker compose -f $COMPOSE_FILE start
}

function stop() {
  docker compose -f $COMPOSE_FILE stop
}

function down() {
  docker compose down -f $COMPOSE_FILE
}

if [ "$1" == "" ]; then
  echo "FATAL no command"
else
  eval $1
fi
