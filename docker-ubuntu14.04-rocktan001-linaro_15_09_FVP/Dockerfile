FROM docker.io/ubuntu:14.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt -f install
RUN apt full-upgrade -y
RUN apt-get install build-essential -y
RUN apt-get install -y \
	acpica-tools \
	bc \
	bison \
	build-essential \
	curl \
	flex \
	g++-multilib \
	gcc-multilib \
	genext2fs \
	git \
	gperf \
	iasl \
	libc6:i386 \
	libstdc++6:i386 \
	libncurses5:i386 \
	libxml2-utils \
	make \
	openjdk-7-jdk \
	python \
	python-mako \
	uuid-dev \
	wget \
	zlib1g:i386 \
	zlib1g-dev:i386 \
	zip

#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#安装supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD etc/supervisord.conf /etc/supervisord.conf

RUN apt-get -y install curl apt-utils  net-tools iputils-ping  

#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh


RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
