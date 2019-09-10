#!/bin/bash
ip_back=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sudo sed "s/localhost/$ip_back/g" /Chess/config.js
