apt update

apt upgrade -y

apt install iputils* vim

Edit /etc/ssh/sshd_config file and set PermitRootLogin to yes

PermitRootLogin yes

Enable and restart ssh service

systemctl enable ssh

systemctl restart ssh

systemctl status ssh #Ensure ssh service is running

Change your root password by running **passwd root**

On your MAC machine, generate a new key pair.

ssh-keygen -b 4096 -t rsa 

Hit enter to keep the default names.

Distribute the generated public key to all machines using below command.

ssh-copy-id root@lb

Here lb is used as a reverse proxy to load balance traffic between two control plane nodes master1 and master2.

## On lb machine which will also be used as template VM to spin up other VMs
apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
