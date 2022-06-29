Docker + Ubuntu-18.04 + openssh-server + RDN2

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```
docker build -t="rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v1.0" .

docker run -tid --name docker-ubuntu18.04-rocktan001_rdn2cfg1 -e SSH_PORT=60024 -e ROOT_PWD=root -e ROCK_USER_PWD=rock  --privileged --net host --restart always  -v /media/disk2/:/media/disk2/  rocktan001/docker-ubuntu18.04-rocktan001_rdn2cfg1:v1.0
```