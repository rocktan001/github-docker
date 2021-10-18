openharmony-docker-standard + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```
$ docker build -t="rocktan001/openharmony-docker-standard-rocktan001:v1.0" .
```

#### run a container with new User and Password

```
$ docker run -tid --restart always --name openharmony-docker-standard-rocktan001 -e ROOT_PWD=root -e ROCK_USER_PWD=rock -v /media/disk2/harmonyos:/home/openharmony -p 8889:22 rocktan001/openharmony-docker-standard-rocktan001:v1.0
```