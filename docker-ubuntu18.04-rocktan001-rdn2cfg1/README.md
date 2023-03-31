Docker + Ubuntu-18.04 + openssh-server + RDN2

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v6.0" .
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10065 -e SSH_PORT=10065 -e ROOT_PWD=root -e YSEMI_USER=10065  --privileged --net host --restart always  -v /media/disk2/:/media/disk2/ -v /media/disk3/:/media/disk3/ rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v5.0

#window
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10065 -e SSH_PORT=10065 -e ROOT_PWD=root -e YSEMI_USER=10065  --privileged --net host --restart always  -v Z:\:/media/disk2/  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0
```





### 192.168.10.72 分配
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10054 -e SSH_PORT=10054 -e ROOT_PWD=root -e YSEMI_USER=10054  --privileged --net host --restart always  -v /home/server/rocktan001/10054:/media/disk2/10054  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10065 -e SSH_PORT=10065 -e ROOT_PWD=root -e YSEMI_USER=10065  --privileged --net host --restart always  -v /home/server/rocktan001/10065:/media/disk2/10065  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0

docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=10059  --privileged --net host --restart always  -v /home/server/rocktan001/10059:/media/disk2/10059  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v1.0


### docker daemon 启用用户隔离
```bash
root@rocktan001:/media/disk3/docker_namespace# cat /etc/docker/daemon.json 
{
          "userns-remap": "default"
}

docker run -tid --name rdn2cfg1_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=10059  --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined  --restart always -p 10059:10059  -v /media/disk3/:/media/disk3/ -v /media/disk2/:/media/disk2/ --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v6.0
sudo systemctl restart docker.service


# 取消隔离 没成功
# docker run -tid --userns=host --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=10059  --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined  --restart always -p 10059:10059  -v /media/disk3/:/media/disk3/ -v /media/disk2/:/media/disk2/  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v5.0

# 72 服务器分配gitlab
sudo docker run --detach \
--hostname 192.168.10.72:8800 \
--publish 443:443 \
--publish 8800:8800 \
--publish 8801:22 \
--name gitlab \
--restart always \
--volume /home/server/rocktan001/gitlab/config:/etc/gitlab \
--volume /home/server/rocktan001/gitlab/logs:/var/log/gitlab \
--volume /home/server/rocktan001/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest

# 72 服务器docker 创建

sudo docker run -tid --name rdn2cfg1_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=10059  --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined  --restart always -p 10059:10059 --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  -v /home/server/rocktan001/docker_share:/home/10059/docker_share -v /home/server/rocktan001/10059:/home/10059  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v6.0
```

```text
docker run -tid --name rdn2cfg1_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=10059  --privileged --net host  --restart always -p 10059:10059 -v /media/disk1:/media/disk1 -v /media/disk3/:/media/disk3/ -v /media/disk2/:/media/disk2/ --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v6.0
```