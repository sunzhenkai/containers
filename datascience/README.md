# Spark
## Submit Task
```shell
docker cp datascience-spark-1:/opt/bitnami/spark .
./bin/spark-submit --class org.apache.spark.examples.SparkPi --master spark://127.0.0.1:8077 --executor-memory 2G --total-executor-cores 5 examples/jars/spark-examples_2.12-3.4.1.jar 1000
```

# Gen PEM file
```shell
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=CN/ST=beijing/L=beijing/O=WII/OU=WII/CN=127.0.0.1"
```