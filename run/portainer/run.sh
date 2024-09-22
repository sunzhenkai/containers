mkdir -p /data/docker/portainer
docker run -d -p 3014:8000 -p 3015:9000 -p 3016:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /data/docker/portainer:/data \
    192.168.6.7:5000/portainer/portainer-ce:latest
