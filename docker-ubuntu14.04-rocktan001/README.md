Docker + Ubuntu-18.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```
$ docker build -t="rocktan001/docker-ubuntu14.04-rocktan001:v1.0" .
```


#### run a container with new User and Password

```
$ docker run -tid --name docker-ubuntu14.04-rocktan001 -e ROOT_PWD=root -e ROCK_USER_PWD=rock -v /media/disk2:/media/disk2 -p 8891:22  rocktan001/docker-ubuntu14.04-rocktan001:v1.0
```
