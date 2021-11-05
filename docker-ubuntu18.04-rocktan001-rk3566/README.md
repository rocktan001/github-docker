Docker + Ubuntu-18.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```
$ docker build -t="rocktan001/docker-ubuntu18.04-rocktan001-rk3566:v1.0" .
```

#### run a container with new User and Password

```
$ docker run -tid --privileged   --restart always --name docker-ubuntu18.04-rocktan001-rk3566 -h docker-ubuntu18.04-rocktan001-rk3566 -e ROOT_PWD=root -e ROCK_USER_PWD=rock -v /dev/bus/usb:/dev/bus/usb -v /media/disk2:/media/disk2 -p 8891:22  rocktan001/docker-ubuntu18.04-rocktan001-rk3566:v1.0
```
