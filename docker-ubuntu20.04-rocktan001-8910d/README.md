Docker + Ubuntu-20.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```
$ docker build -t="rocktan001/docker-ubuntu20.04-rocktan001-8910d:v1.0" .
```


#### run a container with new User and Password




```
docker run -tid --privileged   --restart always --name docker-ubuntu20.04-rocktan001-8910d -e ROOT_PWD=root -e ROCK_USER_PWD=rock -v /media/disk2/harmonyos/8910d:/media/disk2/harmonyos/8910d -p 8894:22 rocktan001/docker-ubuntu20.04-rocktan001-8910d:v1.0
```