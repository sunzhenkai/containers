#!/bin/bash
set -e

DATA_BASE=/data/docker/server
mkdir -p $DATA_BASE

# caddy
function InitCaddy() {
    CADDY_BASE=${DATA_BASE}/caddy
    CADDY_FILE=${CADDY_BASE}/Caddyfile
    mkdir -p ${CADDY_BASE}/{data,config}
    [[ -d ${CADDY_FILE} ]] && rmdir ${CADDY_FILE}
    touch ${CADDY_FILE}
}
InitCaddy

function GenHarborCert() {
    HOST=$1
    openssl genrsa -out ca.key 4096
    openssl req -x509 -new -nodes -sha512 -days 3650 -subj "/C=PH/ST=NCR/L=Manila/O=Any/OU=Personal/CN=$HOST" -key ca.key -out ca.crt
    openssl genrsa -out $HOST 4096
    openssl req -sha512 -new -subj "/C=CN/PH=NCR/L=Manila/O=Any/OU=Personal/CN=$HOST" -key $HOST.key -out $HOST.csr
    cat >v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1=$HOST
EOF
    openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CA ca.crt -CAkey ca.key -CAcreateserial -in $HOST.csr -out $HOST.crt
    openssl x509 -inform PEM -in $HOST.crt -out $HOST.cert
}
