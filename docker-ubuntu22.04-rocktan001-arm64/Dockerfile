FROM arm64v8/ubuntu:22.04
#作者
MAINTAINER ROCK


RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata build-essential


#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#安装supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD etc/supervisord.conf /etc/supervisord.conf

RUN apt-get -y install curl apt-utils  net-tools iputils-ping

RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

COPY etc/sshd_config /etc/ssh/sshd_config


RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
