FROM docker.io/ubuntu:14.04
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

RUN apt-get -y install libssl-dev git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown libxml2-utils xsltproc bc

RUN apt install -y python-pip python-dev

RUN apt-get -y install software-properties-common

RUN add-apt-repository ppa:openjdk-r/ppa

RUN apt-get update

RUN apt-get -y install openjdk-8-jdk
#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

#编译pycrypto
COPY etc/pycrypto-2.6.1.tar.gz /root/pycrypto-2.6.1.tar.gz
RUN cd /root && tar -zxvf pycrypto-2.6.1.tar.gz && cd pycrypto-2.6.1 && python setup.py build && python setup.py install

RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
