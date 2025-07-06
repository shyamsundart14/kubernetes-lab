#!/bin/bash

BASE_DIR="/tmp"
REMOTE_USER="root"
TMP_PATH="/tmp"
PKI_PATH="/etc/kubernetes/pki"

for dir in "$BASE_DIR"/192.168.*; do
  [ -d "$dir" ] || continue

  IP=$(basename "$dir")
  echo "==> Copying files to $IP..."

  # Create required directories on remote host
  ssh -o BatchMode=yes "$REMOTE_USER@$IP" "mkdir -p $PKI_PATH/etcd" || {
    echo "❌ Failed to SSH into $IP. Skipping..."
    continue
  }

  # Copy kubeadm config to /tmp
  scp -o BatchMode=yes "$dir/kubeadmcfg.yaml" "$REMOTE_USER@$IP:$TMP_PATH/" || {
    echo "❌ Failed to copy kubeadmcfg.yaml to $IP"
    continue
  }

  # Copy certificates
  scp -o BatchMode=yes "$dir/pki/apiserver-etcd-client.crt" "$REMOTE_USER@$IP:$PKI_PATH/" || {
    echo "❌ Failed to copy apiserver-etcd-client.crt to $IP"
    continue
  }

  scp -o BatchMode=yes "$dir/pki/apiserver-etcd-client.key" "$REMOTE_USER@$IP:$PKI_PATH/" || {
    echo "❌ Failed to copy apiserver-etcd-client.key to $IP"
    continue
  }

  scp -o BatchMode=yes -r "$dir/pki/etcd" "$REMOTE_USER@$IP:$PKI_PATH/" || {
    echo "❌ Failed to copy etcd directory to $IP"
    continue
  }

  echo "✅ Finished copying to $IP."
done
