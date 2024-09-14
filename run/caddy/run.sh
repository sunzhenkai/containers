mkdir -p /data/docker/caddy
touch /data/docker/caddy/Caddyfile
docker run -d -p 3080:80 -p 3443:443 --name caddy \
    --restart=always \
    -v /data/docker/caddy/data:/data \
    -v /data/docker/caddy/config:/config \
    -v /data/docker/caddy/Caddyfile:/etc/caddy/Caddyfile \
    caddy
