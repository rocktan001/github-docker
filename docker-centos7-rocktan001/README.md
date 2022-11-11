#### build image
docker build -t="rocktan001/docker-centos7-rocktan001_openeuler:v1.0" .


docker run -tid --name euler_10060 -e SSH_PORT=10060 -e ROOT_PWD=root -e YSEMI_USER=Y10060    --restart always -p 10060:10060  -v /media/disk3/:/media/disk3/ -v /media/disk2/:/media/disk2/  rocktan001/docker-centos7-rocktan001_openeuler:v1.0



