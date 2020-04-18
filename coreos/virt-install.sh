#/bin/bash

export fcos_version=31.20200223.3.2
export kernel=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${fcos_version}/x86_64/fedora-coreos-${fcos_version}-live-kernel-x86_64
export initrd=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${fcos_version}/x86_64/fedora-coreos-${fcos_version}-live-initramfs.x86_64.img
export ignition_url=http://192.168.122.1:8080/my.ign
export kernel_args="ip=dhcp rd.neednet=1 console=tty0 coreos.liveiso=/ console=ttyS0 coreos.inst.install_dev=/dev/sda coreos.inst.stream=stable coreos.inst.ignition_url=${ignition_url}"
sudo virt-install --name ${machine_name} --ram 4048 --graphics=none --vcpus 2 --disk size=20 \
     --network bridge=virbr0 \
     --install kernel=${kernel},initrd=${initrd},kernel_args_overwrite=yes,kernel_args="${kernel_args}"

