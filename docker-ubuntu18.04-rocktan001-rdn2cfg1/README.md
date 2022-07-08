Docker + Ubuntu-18.04 + openssh-server + RDN2

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0" .
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10065 -e SSH_PORT=10065 -e ROOT_PWD=root -e YSEMI_USER=10065  --privileged --net host --restart always  -v /media/disk2/:/media/disk2/  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0
```





### 192.168.10.72 分配
docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10065 -e SSH_PORT=10065 -e ROOT_PWD=root -e YSEMI_USER=10065  --privileged --net host --restart always  -v /home/server/rocktan001/10065:/media/disk2/10065  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v3.0

docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1_10066 -e SSH_PORT=10066 -e ROOT_PWD=root -e YSEMI_USER=10066  --privileged --net host --restart always  -v /home/server/rocktan001/10066:/media/disk2/10066  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v1.0