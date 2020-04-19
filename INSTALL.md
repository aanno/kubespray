# Install kubespray

* https://kubernetes.io/docs/setup/production-environment/tools/kubespray/
* https://docs.fedoraproject.org/en-US/fedora-coreos/bare-metal/
* https://kubespray.io/#/docs/fcos

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

## kube container

```bash
# podman images
REPOSITORY                           TAG       IMAGE ID       CREATED       SIZE
docker.io/coredns/coredns            1.6.9     faac9e62c0d6   3 weeks ago   43.3 MB
k8s.gcr.io/kube-proxy                v1.17.4   6dec7cfde1e5   5 weeks ago   118 MB
k8s.gcr.io/kube-apiserver            v1.17.4   2e1ba57fe95a   5 weeks ago   173 MB
k8s.gcr.io/kube-controller-manager   v1.17.4   7f997fcf3e94   5 weeks ago   163 MB
k8s.gcr.io/kube-scheduler            v1.17.4   5db16c1c7aff   5 weeks ago   96 MB
k8s.gcr.io/pause                     3.1       da86e6ba6ca1   2 years ago   749 kB
```

* Test if your podman/docker could pull and run these image. If not, you've got a
  problem.


## Problems

* https://discussion.fedoraproject.org/t/installing-using-cri-o-on-fedora-coreos/15961/5

 9280 server.go:191] Warning: For remote container runtime, --pod-infra-container-image is ignored in kubelet, which s>
s been deprecated, This parameter should be set via the config file specified by the Kubelet's --config flag. See https>
  9280 feature_gate.go:243] feature gates: &{map[]}
  9280 feature_gate.go:243] feature gates: &{map[]}
