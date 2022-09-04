Docker + Ubuntu-18.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```bash
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001:v2.0" .


## 直接配置ssh 端口，并分配10060 用户
docker run -tid --name docker-ubuntu18.04-rocktan001_10060 \
-e SSH_PORT=10060 \
-e ROOT_PWD=root \
-e YSEMI_USER=10060 \
-p 10060:10060 \
--restart always \
-v /media/disk3/:/media/disk3/ \
-v /media/disk2/:/media/disk2/ \
rocktan001/docker-ubuntu18.04-rocktan001:v2.0


## 重新配置rock用户密码
docker run -tid --name docker-ubuntu18.04-rocktan001_10061 \
-e SSH_PORT=10061 \
-p 10061:10061 \
-e ROOT_PWD=root \
-e ROCK_USER_PWD=F96AEB124CXIAOQIANG4423 \
--restart always \
-v /media/disk3/:/media/disk3/ \
-v /media/disk2/:/media/disk2/ \
rocktan001/docker-ubuntu18.04-rocktan001:v2.0

```

