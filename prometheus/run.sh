mkdir -p /data/containers/prometheus
chmod +777 /data/containers/prometheus
cp prometheus.yml /data/containers/prometheus/
docker run -d \
    -p 9090:9090 \
    -v /data/containers/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v /data/containers/prometheus:/prometheus \
    --name prometheus \
    prom/prometheus