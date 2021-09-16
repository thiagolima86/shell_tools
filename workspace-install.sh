#!/usr/bin/env bash

function install_postman_from()
{
    echo "\n\nInstalando Postman ...\n"
    path_postman=~/Downloads/postman
    file_name_postman=postman-lastest_amd64.tar.gz
    mkdir $path_postman
    wget $1 -O "$path_postman/$file_name_postman"
    sudo tar zxvf "$path_postman/$file_name_postman" -C $path_postman
    sudo mv "$path_postman/Postman" /opt
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
    desktop_icon='[Desktop Entry]
Type=Application
Name=Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec="/opt/Postman/Postman"
Comment=Postman GUI
Categories=Development;Code;'
    touch $path_postman/postman.desktop
    sudo echo $desktop_icon >> $path_postman/postman.desktop
    sudo mv $path_postman/postman.desktop /usr/share/applications/postman.desktop
    sudo rm -R $path_postman
}


#Instalar minha workspace de programação
sudo apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential \
vim \
guake \
git-all \

install_postman_from 'https://dl.pstmn.io/download/latest/linux'

echo "\n\nInstalando vscode ...\n"
path_vscode=/tmp/code_latest_amd64.deb
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O $path_vscode
sudo dpkg -i $path_vscode

#install extension vscode
echo "Instalando extensões do vscode ...\n"
code --install-extension eamodio.gitlens
code --install-extension ms-azuretools.vscode-docker
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension wingrunr21.vscode-ruby
code --install-extension castwide.solargraph
code --install-extension misogi.ruby-rubocop
code --install-extension rebornix.ruby
code --install-extension Hridoy.rails-snippets
code --install-extension danielpinto8zz6.c-cpp-compile-run
code --install-extension ms-vscode.cpptools

#config vscode
echo "\n\nconfigurando vscode ...\n"
sudo rm "${HOME}/.config/Code/User/settings.json"
wget -P "${HOME}/.config/Code/User" https://raw.githubusercontent.com/thiagolima86/shell_tools/main/.config/Code/User/settings.json

#config workspace folder
echo "\n\ncriando pasta workspace...\n"
mkdir "${HOME}/workspace"


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
