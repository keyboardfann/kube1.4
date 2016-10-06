#!/bin/sh

tee /etc/yum.repos.d/kubernetes.repo <<-'EOF'
[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0
EOF

## Install docker,etcd, flannel
yum install -y docker etcd flannel

## Create need folder
mkdir -p /etc/kubernetes/conf /opt/kubernetes/bin

## Copy file to folder
cp config/* /etc/kubernetes/conf/
cp bin/* /opt/kubernetes/bin/
cp systemd/* /usr/lib/systemd/system/
/bin/cp -rf config/etcd.conf /etc/etcd/
/bin/cp -rf config/flanneld /etc/sysconfig/

## Reload systemd
systemctl daemon-reload

## unzip command
cd /opt/kubernetes/bin/; for i in `ls`;do tar -zxvf $i;done


## Start master service
for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler; do
systemctl restart $SERVICES
systemctl enable $SERVICES
systemctl status $SERVICES
done

## crete flannel network
etcdctl mk /atomic.io/network/config '{"Network":"172.17.0.0/16"}'


## Start slave service
for SERVICES in kube-proxy kubelet docker flanneld; do
systemctl restart $SERVICES
systemctl enable $SERVICES
systemctl status $SERVICES
done
