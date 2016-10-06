# kube1.4

##Folder Description

	config -> /etc/kubernetes/conf

	bin -> /opt/kubernetes/bin/

	systemd/* -> /usr/lib/systemd/system/


##Config need to moidify

	[root@kmaster kube1.4]# grep -R "kmaster.com" config/
	config/etcd.conf:ETCD_ADVERTISE_CLIENT_URLS="http://kmaster.com:2379"
	config/flanneld:FLANNEL_ETCD="http://kmaster.com:2379"
	config/kube-apiserver:KUBE_ETCD_SERVERS="--etcd-servers=http://kmaster.com:2379"
	config/kube-controller-manager:KUBE_MASTER="--master=kmaster.com:8080"
	config/kube-proxy:NODE_HOSTNAME="--hostname-override=kmaster.com"
	config/kube-proxy:KUBE_MASTER="--master=http://kmaster.com:8080"
	config/kube-scheduler:KUBE_MASTER="--master=kmaster.com:8080"
	config/kubelet:NODE_HOSTNAME="--hostname-override=kmaster.com"
	config/kubelet:KUBELET_API_SERVER="--api-servers=kmaster.com:8080"
	[root@kmaster kube1.4]# grep -R "192.168.50.100" config/
	config/kube-apiserver:KUBE_ADVERTISE_ADDR="--advertise-address=192.168.50.100"


##Install 

	[root@kmaster kube1.4]# sh setup.sh

##Check install 
	[root@kmaster kube1.4]# /opt/kubernetes/bin/kubectl get nodes
	NAME          STATUS    AGE
	kmaster.com   Ready     2m

