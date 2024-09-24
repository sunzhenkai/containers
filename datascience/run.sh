#!/bin/bash
set -e
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $BASE/../base.sh
CUR_DATA_DIR=$DATA_DIR/$(basename $BASE)
COMPOSE_FILE=$BASE/docker-compose.yaml

function create() {
  docker compose up -d -f $COMPOSE_FILE
}

function start() {
  docker compose start -f $COMPOSE_FILE
}

function stop() {
  docker compose stop -f $COMPOSE_FILE
}

function down() {
  docker compose down -f $COMPOSE_FILE
}

function init() {
  mkdir -p /data/docker/datascience/data/kafka
  mkdir -p /data/docker/datascience/data/hadoop
  mkdir -p /data/docker/datascience/data/mariadb
  mkdir -p /data/docker/datascience/data/clickhouse
  mkdir -p /data/docker/datascience/data/consul
  mkdir -p /data/docker/datascience/data/zookeeper
  mkdir -p /data/docker/datascience/data/postgresql
  mkdir -p /data/docker/datascience/data/redis
  mkdir -p /data/docker/datascience/data/mongodb
  mkdir -p /data/docker/datascience/data/grafana
  mkdir -p /data/docker/datascience/data/dolphinscheduler-logs
  mkdir -p /data/docker/datascience/data/dolphinscheduler-worker-data
  mkdir -p /data/docker/datascience/data/dolphinscheduler-shared-local
  mkdir -p /data/docker/datascience/data/dolphinscheduler-resource-local
  mkdir -p /data/docker/datascience/data/flink
  mkdir -p /data/docker/datascience/data/portainer
  mkdir -p /data/docker/datascience/data/gitlab/{config,log,data,runner}
}

if [ "$1" == "" ]; then
  echo "FATAL no command"
else
  eval $1
fi
