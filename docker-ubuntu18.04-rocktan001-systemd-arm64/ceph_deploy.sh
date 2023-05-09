#!/bin/bash

set -x
function ssh_deploy()
{	
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
	sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa.pub root@systemd02
	sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa.pub root@systemd03
}

function ceph_deploy()
{
	ceph-deploy new systemd01 systemd02 systemd03
	ceph-deploy install systemd01 systemd02 systemd03
	ceph-deploy mon create systemd01 systemd02 systemd03
	ceph-deploy gatherkeys systemd01 systemd02 systemd03

	# 拷贝权限
	cp -a ceph.client.admin.keyring /etc/ceph/
	ceph-deploy osd prepare systemd01:/mnt/ceph1
	ceph-deploy osd prepare systemd02:/mnt/ceph2
	ceph-deploy osd prepare systemd03:/mnt/ceph3

	ceph-deploy osd activate systemd01:/mnt/ceph1
	ceph-deploy osd activate systemd02:/mnt/ceph2
	ceph-deploy osd activate systemd03:/mnt/ceph3

	ceph-deploy mds create systemd01 systemd02 systemd03

	ceph-deploy --overwrite-conf config push systemd01 systemd02 systemd03

	# 配置Ceph MGR
	ceph-deploy mgr create systemd01
	ceph mgr module disable dashboard
	ceph mgr module enable  dashboard
}
ssh_deploy
ceph_deploy