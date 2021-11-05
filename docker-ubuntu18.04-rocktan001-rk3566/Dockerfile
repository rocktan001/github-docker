FROM rocktan001/docker-ubuntu18.04-rocktan001:v1.0
#作者
MAINTAINER ROCK

RUN apt-get update

# 安装 OpenJDK 8:
RUN apt-get -y install openjdk-8-jdk

#安装supervisor
RUN apt-get -y install git gnupg flex bison gperf libsdl1.2-dev \
	libesd-java libwxgtk3.0-dev squashfs-tools build-essential zip curl \
	libncurses5-dev zlib1g-dev pngcrush schedtool libxml2 libxml2-utils \
	xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev \
	lib32readline-dev gcc-multilib libswitch-perl libssl-dev unzip zip device-tree-compiler \
	liblz4-tool python-pyelftools python3-pyelftools bc cpio rsync python2.7-dev


#清理 apt
RUN apt-get -y autoremove && apt-get clean
