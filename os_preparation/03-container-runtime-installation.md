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

wget https://github.com/containerd/containerd/releases/download/v2.1.0/containerd-2.1.0-linux-arm64.tar.gz

tar Cxzvf /usr/local containerd-2.1.0-linux-arm64.tar.gz

mkdir /etc/containerd

containerd config default > config.toml

cp config.toml /etc/containerd

wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

cp containerd.service /etc/systemd/system/

systemctl daemon-reload

systemctl enable --now containerd

wget https://github.com/opencontainers/runc/releases/download/v1.3.0-rc.1/runc.arm64

install -m 755 runc.arm64 /usr/local/sbin/runc

wget https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz

sudo mkdir -p /opt/cni/bin

wget https://github.com/containernetworking/plugins/releases/download/v1.7.0/cni-plugins-linux-arm-v1.7.0.tgz

mkdir -p /opt/cni/bin

tar Cxzvf /opt/cni/bin cni-plugins-linux-arm-v1.7.0.tgz

tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.0.tgz

Set SystemdCgroup = true in file /etc/containerd/config.toml under [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]

systemctl restart containerd

systemctl status containerd

apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
