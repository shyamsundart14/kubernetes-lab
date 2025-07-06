Configure kubelet to be the service manager for etcd. Use the script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/etcd-config.sh). This needs to be done on nodes etcd1, etcd2 & etcd3.

**Do these steps from lb server.**

Create configuration files for kubeadm using script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/kubeadm-config.sh)

Generate certificate authority for etcd using below command.

kubeadm init phase certs etcd-ca

Two files ca.crt and ca.key will be created under /etc/kubernetes/pki/etcd/ folder

Generate certificates for each etcd member using script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/generate_certs.sh).

Copy over the generated kubeadm config file and certificates using script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/copy_certs.sh).

After copying over, the kubeadmcfg.yaml file should be under /tmp directory and other certificate files should be under /etc/kubernetes/pki and /etc/kubernetes/pki/etcd/ directory.
