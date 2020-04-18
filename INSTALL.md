# Install kubespray

## Firewall ports


## etcd 


## kubelet

* /usr/local/bin/kubelet --cgroup-driver=systemd --logtostderr=true --v=2 --node-ip=192.168.122.8 --hostname-override=node0 --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/etc/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/kubelet.conf --pod-infra-container-image=k8s.gcr.io/pause:3.1 --container-runtime=remote --container-runtime-endpoint=/var/run/crio/crio.sock --runtime-cgroups=/systemd/system.slice --network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin --volume-plugin-dir=/var/lib/kubelet/volumeplugins


## kubeadmin init

* curl http://localhost:10248/healthz
* Initialize first master
* /usr/local/bin/kubeadm init --config=/etc/kubernetes/kubeadm-config.yaml --ignore-preflight-errors=all --skip-phases=addon/coredns --upload-certs
* curl https://192.168.122.8:6443/api/v1/namespaces/kube-system/secrets?timeout=10s
* /usr/local/bin/kubeadm --v 9 --kubeconfig /etc/kubernetes/admin.conf token create


### Links

* https://stackoverflow.com/questions/53383994/error-marking-master-timed-out-waiting-for-the-condition-kubernetes
  + kubeadm init --pod-network-cidr=10.244.0.0/16
* https://github.com/kubernetes-sigs/kubespray/issues/4606
  + ansible-playbook --flush-cache -i inventory/mycluster/hosts.yml reset.yml
* If 'Initialize first master fails' you try the manual setup
  + kubeadm reset -f && rm -rf /etc/kubernetes/
  + kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all --v 9 --cri-socket=/var/run/crio/crio.sock


## cri-o

* https://github.com/cri-o/cri-o/blob/master/tutorials/kubeadm.md
* KUBELET_EXTRA_ARGS=--feature-gates="AllAlpha=false,RunAsGroup=true" --container-runtime=remote --cgroup-driver=systemd --container-runtime-endpoint='unix:///var/run/crio/crio.sock' --runtime-request-timeout=5m

