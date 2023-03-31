Docker + Ubuntu-22.04 + openssh-server + RDN2

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```
docker build -t="rocktan001/docker-ubuntu22.04-rocktan001_arm64:v1.0" .
docker run -tid --name docker-ubuntu22.04-rocktan001_arm64_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=Y10059  --privileged --net host --restart always  -v /home/yyx/rocktan:/home/Y10059 rocktan001/docker-ubuntu22.04-rocktan001_arm64:v1.0


# davy
docker run -tid --name docker-ubuntu22.04-rocktan001_arm64_10012 -e SSH_PORT=10012 -e ROOT_PWD=root -e YSEMI_USER=Y10012  --privileged --net host --restart always  -v /home/yyx/davy:/home/Y10012  -v /home/robox/share:/home/Y10012/share rocktan001/docker-ubuntu22.04-rocktan001_arm64:v1.0
```


# 陈总
docker run -tid --name docker-ubuntu22.04-rocktan001_arm64_10007 -e SSH_PORT=10007 -e ROOT_PWD=root -e YSEMI_USER=Y10007  --privileged --net host --restart always  -v /home/yyx/chenzhengsheng:/home/yyx/Y10012 rocktan001/docker-ubuntu22.04-rocktan001_arm64:v1.0
```