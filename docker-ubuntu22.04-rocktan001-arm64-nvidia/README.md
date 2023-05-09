Docker + Ubuntu-22.04 + openssh-server + RDN2

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"
* `SSH_PORT` : ssh listen port   default 60023


#### build image


```
# rock
docker build -t="rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0" .
docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_10059 -e SSH_PORT=10059 -e ROOT_PWD=root -e YSEMI_USER=Y10059  --privileged --net host --restart always  -v /home/yyx/rocktan:/home/Y10059 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0

## cuda-11.7.0
docker build -t="rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v2.0" -f Dockerfile.cuda-11.7.0-cudnn8-devel-ubuntu22.04 .
docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_20059 -e SSH_PORT=20059 -e ROOT_PWD=root -e YSEMI_USER=Y20059  --privileged --net host --restart always  -v /home/yyx/rocktan:/home/Y20059 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v2.0

# davy
sudo docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_10012 -e SSH_PORT=10012 -e ROOT_PWD=root -e YSEMI_USER=Y10012  --privileged --net host --restart always  -v /home/yyx/davy:/home/Y10012 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0
sudo docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_10013 -e SSH_PORT=10013 -e ROOT_PWD=root -e YSEMI_USER=Y10013  --privileged --net host --restart always  -v /home/yyx/davy2:/home/Y10013 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0
sudo docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_10014 -e SSH_PORT=10014 -e ROOT_PWD=root -e YSEMI_USER=Y10014  --privileged --net host --restart always  -v /home/yyx/davy3:/home/Y10014 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0
```


# 陈总
docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_10007 -e SSH_PORT=10007 -e ROOT_PWD=root -e YSEMI_USER=Y10007  --privileged --net host --restart always  -v /home/yyx/chen:/home/yyx/Y10012 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0
docker run --runtime=nvidia --gpus all  -tid --name docker-ubuntu22.04-rocktan001_arm64_20007 -e SSH_PORT=20007 -e ROOT_PWD=root -e YSEMI_USER=Y20007  --privileged --net host --restart always  -v /home/yyx/chen:/home/Y20007 rocktan001/docker-ubuntu22.04-rocktan001_arm64_nvidia:v1.0
```