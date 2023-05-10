FROM docker.io/ubuntu:18.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list

RUN mv /etc/apt/sources.list /etc/apt/sources_backup.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic universe " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates universe " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic multiverse " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates multiverse " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security universe " >> /etc/apt/sources.list && \
	echo "deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security multiverse " >> /etc/apt/sources.list && \
	echo "deb http://archive.canonical.com/ubuntu bionic partner " >> /etc/apt/sources.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install systemd
RUN apt-get -y install ceph-deploy
RUN apt-get -y install sshpass
#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN apt-get -y install curl apt-utils  net-tools iputils-ping


#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:root" | chpasswd
RUN useradd -m -s /bin/bash rock
RUN echo "rock:rock" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

COPY etc/sshd_config /etc/ssh/sshd_config

RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]
ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/bin/systemd"]
