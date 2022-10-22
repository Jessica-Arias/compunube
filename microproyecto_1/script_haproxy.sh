#!/bin/bash

echo "instalando un servidor haproxy"

sudo wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

sudo echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo unzip consul.zip
sudo rm -f consul.zip

sudo apt update && sudo apt install consul -y

sudo mkdir -p /etc/consul.d/scripts
sudo mkdir /var/consul

echo "Crear llave"
key = $(sudo consul keygen)

sudo cp -f /home/vagrant/config.json /etc/consul.d/config.json

sudo sed -i "s|\"encrypt\"\:\ \".*\"|\"encrypt\"\:\ \"$key\"|g" /etc/consul.d/config.json

sudo cp -v /etc/consul.d/config.json /vagrant/config_1.json

IP=192.168.100.2
echo "Actualización ip"

sudo sed -i "s|IP|$IP|g" /etc/consul.d/config.json


sudo apt install haproxy -y
sudo cp -f /home/vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg

sudo systemctl enable haproxy
sudo systemctl restart haproxy

echo "Crear Servicio Consul"

sudo cp -f /home/vagrant/consul_h.service /etc/systemd/system/consul.service

sudo systemctl daemon-reload

sudo systemctl enable consul
sudo systemctl start consul
sudo systemctl restart consul
