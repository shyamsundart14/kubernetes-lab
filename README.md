# Kubernetes-lab
This repository walks you through the process of setting up a highly available kubernetes cluster with three external etcd nodes. There are two control nodes behind a nginx reverse proxy and three worker nodes to host applications. 

## Lab hosts

| Hostname  | IP |
| ------------- | ------------- |
| lb | 192.168.68.10  |
| master1  | 192.168.68.11 |
| master2  | 192.168.68.12 |
| etcd1  | 192.168.68.13 |
| etcd2  | 192.168.68.14 |
| etcd3  | 192.168.68.15 |
| worker1  | 192.168.68.16 |
| worker2  | 192.168.68.17 |
| worker3  | 192.168.68.16 |

Please note that these VMs are deployed on top of UTM using Ubuntu 24.04 ARM64 image.
