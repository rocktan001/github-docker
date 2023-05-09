Docker + Ubuntu-18.04 + openssh-server + systemd

#### parameter

* `ROOT_PWD` : root Password   default "root"
* `ROCK_USER_PWD` : root Password   default "rock"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```text
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001_systemd-arm64:v1.0" .
```


#### 创建systemd ceph 容器
```text
docker run -tid --name systemd01   \
--hostname=systemd01  --net host \
--privileged --restart always  \
-e SSH_PORT=10060 -e ROOT_PWD=root -e YSEMI_USER=10060 \
--add-host=systemd01:192.168.199.227 --add-host=systemd02:10.10.0.102 --add-host=systemd03:10.10.0.103 \
-v /media/disk1:/media/disk1 -v /mnt/ceph1:/mnt/ceph1  \
     --env container=docker \
     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
     --mount type=tmpfs,destination=/tmp \
     --mount type=tmpfs,destination=/run \
     --mount type=tmpfs,destination=/run/lock \
rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0

docker run -tid --name systemd02   \
--hostname=systemd02  --network=cluster-net --ip=10.10.0.102 \
--privileged --restart always  \
--add-host=systemd01:192.168.199.227 --add-host=systemd02:10.10.0.102 --add-host=systemd03:10.10.0.103 \
-e SSH_PORT=22 -e ROOT_PWD=root -e YSEMI_USER=10060 \
-v /mnt/ceph2:/mnt/ceph2  \
     --env container=docker \
     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
     --mount type=tmpfs,destination=/tmp \
     --mount type=tmpfs,destination=/run \
     --mount type=tmpfs,destination=/run/lock \
rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0

docker run -tid --name systemd03   \
--hostname=systemd03  --network=cluster-net --ip=10.10.0.103 \
--add-host=systemd01:192.168.199.227 --add-host=systemd02:10.10.0.102 --add-host=systemd03:10.10.0.103 \
--privileged --restart always  \
-e SSH_PORT=22 -e ROOT_PWD=root -e YSEMI_USER=10060 \
-v /mnt/ceph3:/mnt/ceph3  \
     --env container=docker \
     --mount type=bind,source=/sys/fs/cgroup,target=/sys/fs/cgroup \
     --mount type=bind,source=/sys/fs/fuse,target=/sys/fs/fuse \
     --mount type=tmpfs,destination=/tmp \
     --mount type=tmpfs,destination=/run \
     --mount type=tmpfs,destination=/run/lock \
rocktan001/docker-ubuntu18.04-rocktan001_systemd:v1.0
```