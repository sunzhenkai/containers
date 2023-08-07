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
## Commands
```shell
# Install
docker compose up -d
# Stop
docker compose stop
# Start
docker compose start
# Uninstall
docker compose down
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
- [Airflow](http://datascience:8208)
- [Azkaban](http://datascience:8261)
    - `username: azkaban, password: azkaban`
- [Consul](http://datascience:8500)
- [Dolphinscheduler](http://datascience:12345/dolphinscheduler/ui)
- [Flink JobManager](http://datascience:8220)
- [Grafana](http://datascience:3000)
- [PhpMyAdmin](http://datascience:8283)
    - `username: root, password: <empty>`
- [Prometheus](http://datascience:8290)
- [Spark](http://datascience:8286)
- [Zeeplin](http://datascience:8280)
- [Jupyter Server](http://datascience:8285)
    - `password: jupyter`

## Ports
```shell
# development ssh
datascience:2025
# hadoop
datascience:8020
# kafka
datascience:9092
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

# Reference
## Gen PEM file
```shell
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=CN/ST=beijing/L=beijing/O=WII/OU=WII/CN=127.0.0.1"
```