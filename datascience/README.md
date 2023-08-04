# Init
## dolphinscheduler
```shell
$ docker exec -it datascience-postgresql-1 bash
$ psql -U postgres
postgres=# CREATE DATABASE dolphinscheduler;
postgres=# CREATE ROLE root WITH CREATEDB CREATEROLE LOGIN SUPERUSER PASSWORD 'root';
$ docker run datascience-dolphinscheduler-schema-initializer-1
$ docker rm datascience-dolphinscheduler-schema-initializer-1
$ docker compose start # 启动 dolphinscheduler
```
## airflow
```shell
$ docker exec -it datascience-postgresql-1 bash
$ psql -U postgres
postgres=# CREATE DATABASE bitnami_airflow;
postgres=# CREATE ROLE bn_airflow WITH CREATEDB CREATEROLE LOGIN SUPERUSER PASSWORD 'bitnami1';
```

# Spark
## Submit Task
```shell
docker cp datascience-spark-1:/opt/bitnami/spark .
./bin/spark-submit --class org.apache.spark.examples.SparkPi --master spark://127.0.0.1:8077 --executor-memory 2G --total-executor-cores 5 examples/jars/spark-examples_2.12-3.4.1.jar 1000
```

# Dolphinscheduler
```
URL http://{ip}:12345/dolphinscheduler
USERNAME admin
PASSWORDdolphinscheduler123
```

# Airflow
```shell
URL http://{ip}:8208/

# 创建用户
airflow users create --username admin --firstname admin --lastname admin --role Admin --email admin 
```

# 

# Gen PEM file
```shell
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=CN/ST=beijing/L=beijing/O=WII/OU=WII/CN=127.0.0.1"
```