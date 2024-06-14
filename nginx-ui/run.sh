docker run -dit \
  --name=nginx-ui \
  --restart=always \
  -e TZ=Asia/Shanghai \
  -v /data/docker/nginx-ui/nginx:/etc/nginx \
  -v /data/docker/nginx-ui/nginx-ui:/etc/nginx-ui \
  -v /data/docker/nginx-ui/www:/var/www \
  -p 3018:80 -p 3020:443 \
  uozi/nginx-ui:latest
