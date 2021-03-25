#!/usr/bin/env bash

#Instalar minha workspace de programação
sudo apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential \
vim \
guake \
git-all \
snapd \

echo "Instalando programas snapd ..."
sudo snap install --classic code
sudo snap install flameshot

#install extension vscode
echo "Instalando extensões do vscode ..."
code --install-extension eamodio.gitlens
code --install-extension Hridoy.rails-snippets
code --install-extension ms-azuretools.vscode-docker
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension wingrunr21.vscode-ruby


#config workspace folder
echo "criando pasta workspace..."
mkdir "${HOME}/workspace"

#config vscode
echo "configurando vscode ..."
sudo rm "${HOME}/.config/Code/User/settings.json"
wget -P "${HOME}/.config/Code/User" https://raw.githubusercontent.com/thiagolima86/shell_tools/main/.config/Code/User/settings.json


#config git 
echo "configurando git ..."
read -p 'Diga seu nome: ' name
read -p '${name}, agora diga seu email: ' email
git config --global core.editor "vim"
git config --global user.name $name
git config --global user.email $email

#config sshkey

echo "${name}, agora vamos configurar seu ssh-keygen"
read -p 'Você tem certeza que quer gerar ssh-keygen?(Y/n) ' keygen
if [ keygen == "Y" ]
then
    ssh-keygen
fi

echo "${name}, copie seu sshkeygen e cole nas configurações do repositorio."
echo "-------------------------------------------------------------------"
cat  $HOME/.ssh/id_rsa.pub
echo "-------------------------------------------------------------------"
