docker run -it -d \
    --restart=always \
    --privileged \
    -v /data:/data \
    --name=vcpkg-builder \
    centos:centos7.9.2009 /bin/bash
