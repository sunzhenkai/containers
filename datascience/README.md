# Init
## Preapare
```shell
bash scripts/prepare.sh
# OR
make prepare
```
## Applications
### dolphinscheduler
```shell
$ docker exec -it datascience-postgresql-1 bash
$ psql -U postgres
postgres=# CREATE DATABASE dolphinscheduler;
postgres=# CREATE ROLE root WITH CREATEDB CREATEROLE LOGIN SUPERUSER PASSWORD 'root';
$ docker run datascience-dolphinscheduler-schema-initializer-1
$ docker rm datascience-dolphinscheduler-schema-initializer-1
$ docker compose start # start dolphinscheduler
```
### airflow
```shell
$ docker exec -it datascience-postgresql-1 bash
$ psql -U postgres
postgres=# CREATE DATABASE bitnami_airflow;
postgres=# CREATE ROLE bn_airflow WITH CREATEDB CREATEROLE LOGIN SUPERUSER PASSWORD 'bitnami1';
```

### gitlab
```shell
USERNAME root
PASSWORD <random>
# Get Password Command: 
# docker exec -it datascience-gitlab-web-1 grep 'Password:' /etc/gitlab/initial_root_password
```
## Commands
```shell
# Install
docker compose -f core.yml up -d
# Stop
docker compose -f core.yml stop
# Start
docker compose -f core.yml start
# Uninstall
docker compose -f core.yml down
# Clear data
make clean  # or bash scripts/clean.sh
```

# Usage
## Spark
### Submit Task
```shell
docker cp datascience-spark-1:/opt/bitnami/spark .
./bin/spark-submit --class org.apache.spark.examples.SparkPi --master spark://127.0.0.1:8077 --executor-memory 2G --total-executor-cores 5 examples/jars/spark-examples_2.12-3.4.1.jar 1000
```

## Dolphinscheduler
```
URL http://{ip}:12345/dolphinscheduler
USERNAME admin
PASSWORD dolphinscheduler123
```

## Airflow
```shell
# create user
airflow users create --username admin --firstname admin --lastname admin --role Admin --email admin 
```

# Access Services
## UI
core
- [Azkaban](http://datascience:8261)
    - `username: azkaban, password: azkaban`
- [Consul](http://datascience:8500)
- [Flink JobManager](http://datascience:8220)
- [Jupyter Server](http://datascience:8285)
    - `password: jupyter`
- [PhpMyAdmin](http://datascience:8283)
    - `username: root, password: <empty>`
- [Spark](http://datascience:8286)
- [Zeeplin](http://datascience:8280)

plugins
- [Airflow](http://datascience:8208)
- [Prometheus](http://datascience:8290)
- [Portainer](http://datascience:8263)
- [Grafana](http://datascience:3000)
- [Gitlab](http://datascience:8929)
- [Dolphinscheduler](http://datascience:12345/dolphinscheduler/ui)

## Ports
```shell
# development ssh
datascience:2025
# hadoop
datascience:8020
# kafka
datascience:9092
# gitlab ssh port
datascience:2224
# mariadb
datascience:3306
# mongodb
datascience:27017
# postgresql
datascience:5432
# prometheus
datascience:8290
# redis
datascience:6379
# zookeeper
datascience:2181
```

# Check
## Hadoop
```shell
hdfs dfs -ls /
hdfs dfs -mkdir /tmp
hdfs dfs -put /path/to/file /tmp/
```

## Spark
Submit example job.
```shell
# copy binary
docker cp datascience-spark:/opt/bitnami/spark /path/to/spark
# submit job
/path/to/spark/bin/spark-submit --master spark://127.0.0.1:7077 --class org.apache.spark.examples.SparkPi /path/to/spark/examples/jars/spark-examples_2.12-3.4.1.jar

# 提交到 yarn
export HADOOP_CONF_DIR=/path/to/hadoop/etc/hadoop
/data/app/spark/bin/spark-submit --master yarn --class org.apache.spark.examples.SparkPi /data/app/spark/examples/jars/spark-examples_2.12-3.4.1.jar
```

# Reference
## Gen PEM file
```shell
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=CN/ST=beijing/L=beijing/O=WII/OU=WII/CN=127.0.0.1"
```