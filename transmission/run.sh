docker run -d \
  --name=transmission \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Asia/Shanghai \
  -e TRANSMISSION_WEB_HOME=/transmission-web-control/ \
  -e USER=admin \
  -e PASS=admin  \
  -e WHITELIST=*  \
  -e PEERPORT=50183  \
  -e HOST_WHITELIST=* \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /data/docker/transmission/config:/config \
  -v /data/downloads:/downloads \
  -v /data/downloads/watch:/watch \
  --restart always \
  lscr.io/linuxserver/transmission:latest