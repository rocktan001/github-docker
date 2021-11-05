FROM docker.io/ubuntu:18.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list

RUN apt-get update

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

RUN  mkdir -p /home/tools \
	&& wget -P /home/tools https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz \
	&& tar xvf /home/tools/go1.14.2.linux-amd64.tar.gz -C /home/tools \
	&& sed -i '$aexport PATH=/home/tools/go/bin:$PATH' /root/.bashrc \
	&& export PATH=/home/tools/go/bin:$PATH
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]

