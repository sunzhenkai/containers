# 配置 docker
```shell
$ vim /etc/docker/daemon.json
{ "insecure-registries":["192.168.6.7:5000"] }
```

# 上传镜像
```shell
docker pull phanan/koel
docker tag phanan/koel 192.168.6.7:5000/phanan/koel
docker push 192.168.6.7:5000/phanan/koel
```