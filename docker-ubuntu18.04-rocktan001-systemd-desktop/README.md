Docker + Ubuntu-18.04 + openssh-server + systemd

#### parameter

* `ROOT_PWD` : root Password   default "root"
* `ROCK_USER_PWD` : root Password   default "rock"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```text
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0" .
```
### 创建

```text
docker run -tid --name rocktan001   \
--hostname=rocktan001 \
--restart always \
-e SSH_PORT=10060 \
-e ROOT_PWD=root \
-e YSEMI_USER=Y10060 \
-p 10060:10060 \
-p 14001:4000 \
--device /dev/fuse --cap-add=SYS_PTRACE --cap-add SYS_ADMIN \
--shm-size=1024m \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--env container=docker \
--mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
--mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
--mount type=tmpfs,destination=/tmp \
--mount type=tmpfs,destination=/run \
--mount type=tmpfs,destination=/run/lock \
-v /media/disk2/:/media/disk2/ \
rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0
```

