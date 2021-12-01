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

## Kubectl
echo -e "---------------------- Install Kubectl ----------------------\n"
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install -y kubectl

## Helm
echo -e "---------------------- Install Helm ----------------------\n"
sudo snap install helm --classic

## Openstack CLI
echo -e "---------------------- Install Openstack CLI ----------------------\n"
sudo subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms --enable=rhel-8-for-x86_64-supplementary-rpms --enable=codeready-builder-for-rhel-8-x86_64-rpms
sudo dnf install -y https://www.rdoproject.org/repos/rdo-release.el8.rpm
sudo yum upgrade -y
sudo yum install -y python3-openstackclient
sudo yum install -y openstack-selinux

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



