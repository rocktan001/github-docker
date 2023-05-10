
FROM centos:7.2.1511

RUN \
	rpm --rebuilddb && yum clean all; \
	yum install -y epel-release; \
	yum update -y; \
	yum install -y \
	iproute \
	python-setuptools \
	hostname \
	inotify-tools \
	yum-utils \
	which \
	jq \
	rsync \
	telnet \
	htop \
	atop \
	iotop \
	mtr \
	supervisor \
	openssh-server \
	dnf \
	make \
	flex \
	gcc \
	bison \
	openssl-devel \
	wget \
	git \
	bc \
	vim && \
	yum clean all && rm -rf /tmp/yum*


ADD etc/supervisord.conf /etc/supervisord.conf
COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh
COPY etc/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
COPY etc/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
RUN chmod 644 /etc/ssh/ssh_host_rsa_key.pub
RUN chmod 600 /etc/ssh/ssh_host_rsa_key


ENTRYPOINT ["/root/startup.sh"]
CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]