docker run -it -d \
    --restart=always \
    --privileged \
    -v /data:/data \
    --name=centos7 \
    centos:centos7.9.2009 /bin/bash
