apt update

apt upgrade -y

apt install iputils* vim

Edit /etc/ssh/sshd_config file and set PermitRootLogin to yes

PermitRootLogin yes

Enable and restart ssh service

systemctl enable ssh
systemctl restart ssh
systemctl status ssh #Ensure ssh service is running

