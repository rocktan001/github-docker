#!/bin/bash

set -x
function ssh_deploy()
{	
	ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
	sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa.pub root@node1
	sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa.pub root@node2
	sshpass -p "root" ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa.pub root@node3
}

function ceph_deploy()
{
	# 创建集群
	# Start deploying a new cluster, and write a CLUSTER.conf and keyring for it
	# 创建ceph-deploy-ceph.log  ceph.conf  ceph.mon.keyring 3个配置文件
	ceph-deploy new admin
	#ceph-deploy new systemd02 systemd03
	# 脚本会帮助node1,node2,node3创建epel源和ceph源，并且自动安装ceph和ceph-radosgw主包
	ceph-deploy install --release luminous admin node1 node2 node3
	# 查看各个node 节点ceph 版本
	# ssh node1 ceph --version
	# ssh node2 ceph --version
	# ssh node3 ceph --version
	# 初始化mon：admin节点--cephu用户执行 。会根据ceph.conf 默认在admin操作
	ceph-deploy mon create-initial
	# 赋予各个节点使用命令免用户名权限：
	ceph-deploy admin node1 node2 node3

	# 添加osd
	ceph-deploy osd prepare node1:/mnt/ceph1
	ceph-deploy osd activate node1:/mnt/ceph1

	ceph-deploy osd prepare node2:/mnt/ceph2
	ceph-deploy osd activate node2:/mnt/ceph2

	ceph-deploy osd prepare node3:/mnt/ceph3
	ceph-deploy osd activate node3:/mnt/ceph3
	# ssh node1 ceph -s
	#root@admin:/home/yyx/rocktan/ceph_osd# ssh node1 ceph -s
	#cluster:
	#  id:     3966e832-c652-4d43-bb71-a653b5976345
	#  health: HEALTH_OK


	# Dashboard的配置：
	# 拷贝权限
	# 安装ceph-mgr：只有luminous才有，为使用dashboard做准备
	ceph-deploy mgr create admin
	cp -a ceph.client.admin.keyring /etc/ceph/
	ceph mgr module enable  dashboard

}
function ceph_nfs_deploy()
{
	# 3 ~ 5 个OSD ，设置PG 128 
	# 5 ~10 个OSD ，设置PG 512 
	# 10~ 50 个OSD ，设置PG 4096 
	ceph osd pool create nfs-ysemi-data 128
	ceph osd pool create nfs-ysemi-metadata 120
	ceph fs new nfs-ysemi nfs-ysemi-metadata nfs-ysemi-data
	ceph fs status nfs-ysemi
	ceph auth get client.admin -o ceph.client.admin.keyring
	ceph-deploy mds create node1 node2 node3
	# ceph osd pool ls detail
	# ceph osd pool get nfs-ysemi-data all
	# ceph osd pool delete nfs-ysemi-data nfs-ysemi-data --yes-i-really-really-mean-it
}
ssh_deploy
ceph_deploy
# ceph_nfs_deploy