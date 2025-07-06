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
  ssh "$REMOTE_USER@$IP" "mkdir -p $PKI_PATH/etcd"

  # Copy kubeadm config to /tmp
  scp "$dir/kubeadmcfg.yaml" "$REMOTE_USER@$IP:$TMP_PATH/"

  # Copy certificates
  scp "$dir/pki/apiserver-etcd-client.crt" "$REMOTE_USER@$IP:$PKI_PATH/"
  scp "$dir/pki/apiserver-etcd-client.key" "$REMOTE_USER@$IP:$PKI_PATH/"
  scp -r "$dir/pki/etcd" "$REMOTE_USER@$IP:$PKI_PATH/"

  echo "==> Finished copying to $IP."
done
