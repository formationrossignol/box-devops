#!/bin/bash

# Update
echo -e "############### Update ###############\n"
sudo yum update -y

# Install packages
echo -e "############### Install Packages ###############\n"
sudo yum install -y epel-release yum-utils 

## Tools
echo -e "---------------------- Install Tools ----------------------\n"
sudo yum install -y python3 python3-pip ansible git net-tools bind bind-utils vim unzip wget nginx

## Snap
echo -e "---------------------- Install Snap ----------------------\n"
sudo yum install -y snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

## Docker
echo -e "---------------------- Install Docker ----------------------\n"
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

## Docker compose
sudo curl –L "https://github.com/docker/compose/releases/download /1.26.2/docker-compose-$(uname -s)-$(uname -m)" –o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Post Install
echo -e "############### Post Install ###############\n"

## Permit ssh password
echo -e "---------------------- Permit SSH Password Login ----------------------\n"
sudo sed 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config > /tmp/sshd_config.tmp.1
sudo sed 's/PasswordAuthentication no/#PasswordAuthentication no/' /tmp/sshd_config.tmp.1 > /etc/ssh/sshd_config
sudo rm /tmp/sshd_config.tmp.1
sudo systemctl reload sshd

## user init
echo -e "---------------------- UserInit ----------------------\n"
echo "vagrant" | passwd --stdin vagrant
sudo usermod -aG docker vagrant

echo -e "You can now connect to your DevOpsBox VM with SSH.\n ssh vagrant@192.168.1.120\n Default password : vagrant\n"



