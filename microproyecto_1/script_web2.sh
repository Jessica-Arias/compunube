#!/bin/bash

echo "instalando un servidor webs"


sudo apt install nodejs -y

sudo apt install npm -y


sudo wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

sudo echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install consul -y


sudo git clone https://github.com/omondragon/consulService

sudo npm init -y

sudo npm install consul

sudo npm install express

echo "Setup Cluster"

sudo cp -f /vagrant/config_1.json /etc/consul.d/config.json

IP=192.168.100.4
echo "Actualización ip"

sudo sed -i "s|IP|$IP|g" /etc/consul.d/config.json

sudo cp -f /home/vagrant/index2.js ./index.js

sudo cp -f /home/vagrant/consul_w.service /etc/systemd/system/consul.service

sudo systemctl daemon-reload

sudo systemctl enable consul

sudo systemctl start consul

sudo systemctl restart consul


