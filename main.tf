provider "aws" {
  access_key = "AKIAWFVWA7VDQAPCUVD2"
  secret_key = "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"
  region = "eu-central-1"
}

resource "aws_instance" "my_back" {
  ami = "ami-010fae13a16763bb4"
  instance_type = "t2.micro"
  key_name = "demo4"

  availability_zone = "eu-central-1b"
  vpc_security_group_ids = ["sg-0c790e6bb304ebb48"]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    Name = "back"
    Owner = "Dima Kyryakov"
    Project = "Demo4"
  }
  user_data =  <<EOF
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

sudo git clone https://github.com/boxerwba/ip.git
sudo curl http://169.254.169.254/latest/meta-data/public-ipv4 > /ip/ip
sudo git remote set-url origin https://boxerwba:Openjok1234@github.com/boxerwba/ip.git
sudo git add *
sudo git commit -m '1'
sudo git push origin master
cd /Chess && sudo npm install gulp@3.9.1
cd /Chess && sudo node ./lib/server/seedDB.js 
cd /Chess && sudo node ./lib/server/index.js &
cd /Chess && sudo gulp start &
EOF
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  triggers = {
    "before" = "${aws_instance.my_back.id}"
  }
}
resource "aws_instance" "my_front" {
  ami = "ami-010fae13a16763bb4"
  instance_type = "t2.micro"
  key_name = "demo4"

  availability_zone = "eu-central-1b"
  vpc_security_group_ids = ["sg-0c790e6bb304ebb48"]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    Name = "front"
    Owner = "Dima Kyryakov"
    Project = "Demo4"
  }

  user_data =  <<EOF
#!/bin/bash
sudo sleep 60
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
sudo git clone https://github.com/boxerwba/ip.git
ip_back=$(cat /ip/ip)
ip_back1=$"(aws_instance.my_front.public_ip)" > /home/ec2-user/1
sed "s/localhost/$ip_back/g" /Chess/config.js
cd /Chess && sudo gulp start &
EOF
}




