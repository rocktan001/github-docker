FROM arm64v8/ubuntu:18.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get -y install systemd
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp*


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
CMD [ "/lib/systemd/systemd", "log-level=info", "unit=sysinit.target" ]

VOLUME [ "/tmp", "/run", "/run/lock" ]
ENTRYPOINT ["/root/startup.sh"]

