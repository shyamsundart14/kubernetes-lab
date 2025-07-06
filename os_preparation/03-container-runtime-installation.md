Here containerd is used as container runtime since our kubernetes cluster will be of version 1.31. 

https://kubernetes.io/docs/setup/production-environment/container-runtimes/
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# Apply sysctl params without reboot
sysctl --system

Verify that net.ipv4.ip_forward is set to 1 with:

sysctl net.ipv4.ip_forward
