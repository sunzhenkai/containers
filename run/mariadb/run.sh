docker run --detach \
    --name mariadb \
    --env MARIADB_USER=admin \
    --env MARIADB_PASSWORD=admin \
    --env MARIADB_ROOT_PASSWORD=root  \
    -p 18089:3306 \
    mariadb:latest