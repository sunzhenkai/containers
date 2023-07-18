mkdir -p /data/docker/filebrowser
FB_DIR_DATA=/data/docker/filebrowser
FB_FILE_DB=$FB_DIR_DATA/filebrowser.db
FB_FILE_CONFIG=$FB_DIR_DATA/settings.json
DATA_ROOT=/data

touch $FB_FILE_DB
[ ! -e $FB_FILE_CONFIG ] && echo '{"port":80,"address":"0.0.0.0","database":"/database.db","root":"/srv"}' > $FB_FILE_CONFIG

# docker run -d --name filebrowser \
#     -v "$DATA_ROOT":/srv \
#     -v "$FB_FILE_DB":/database/filebrowser.db \
#     -v "$FB_FILE_CONFIG":/config/settings.json \
#     -e PUID=$(id -u) \
#     -e PGID=$(id -g) \
#     -p 3010:8080 \
#     filebrowser/filebrowser:s6

docker run -d --name filebrowser \
    -v "$DATA_ROOT":/srv \
    -v "$FB_FILE_DB":/database.db \
    -v "$FB_FILE_CONFIG":/.filebrowser.json \
    -u $(id -u):$(id -g) \
    -p 3010:80 \
    filebrowser/filebrowser