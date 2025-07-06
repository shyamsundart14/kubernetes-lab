Here containerd is used as container runtime since our kubernetes cluster will be of version 1.31. 

https://kubernetes.io/docs/setup/production-environment/container-runtimes/
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

sysctl --system

Verify that net.ipv4.ip_forward is set to 1 with:

sysctl net.ipv4.ip_forward

Both overlay and br_netfilter are essential for the proper functioning of container networking and filesystem layering. Lets make sure they are loaded during boot.

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
