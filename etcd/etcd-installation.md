These steps were performed from lb server.

Configure kubelet to be the service manager for etcd. Use the script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/etcd-config.sh)

Create configuration files for kubeadm using script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/kubeadm-config.sh)

Generate certificate authority for etcd using below command.

kubeadm init phase certs etcd-ca

Two files ca.crt and ca.key will be created under /etc/kubernetes/pki/etcd/ folder

Generate certificates for each etcd member using script [here](https://github.com/shyamsundart14/kubernetes-lab/blob/main/scripts/generate_certs.sh).
