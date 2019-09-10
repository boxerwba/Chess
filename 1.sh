#!/bin/bash
sudo yum install -y nano git 
sudo git clone https://github.com/boxerwba/Chess.git
sudo yum install -y gcc-c++ make
sudo curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
sudo yum install -y nodejs
sudo npm install -g gulp@3.9.1
sudo touch /etc/yum.repos.d/mongodb-org-4.2.repo
sudo chmod 777 /etc/yum.repos.d/mongodb-org-4.2.repo
sudo echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' > /etc/yum.repos.d/mongodb-org-4.2.repo
sudo yum install -y mongodb-org
sudo service mongod start
cd /Chess && sudo npm install gulp@3.9.1
cd /Chess && sudo node ./lib/server/seedDB.js
ip_back=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sudo sed "s/localhost/$ip_back/g" /Chess/config.js
