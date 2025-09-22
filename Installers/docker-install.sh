#!/usr/bin/env bash

# Prepara pra instalar o docker
sudo apt update
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update

# instalação
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y

# adicionar usuario no grupo docker
sudo groupadd docker
sudo usermod -aG docker $USER

#mensagem

echo "Reinicie o computador"

