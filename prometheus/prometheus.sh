docker run -d \
    -p 9090:9090 \
    -v /data/containers/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v /data/docker/prometheus:/prometheus \
    --name prometheus \
    prom/prometheus