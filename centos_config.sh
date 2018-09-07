#!/bin/bash 

#install ssh 
sudo yum install openssh-server
sudo service ssh start
sudo service sshd start

#install tmux
wget http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -ivh epel-release-6-8.noarch.rpm
sudo yum install tmux
sudo yum -y install epel-releas

#install htop
sudo yum install -y htop

#install zsh
sudo yum install zsh
sudo yum install git
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

#install gcc
sudo yum install gcc
