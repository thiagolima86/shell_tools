#!/usr/bin/env bash

download_path="$HOME/Downloads/programas"

deb_links=(
  "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  "https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/10161/wps-office_11.1.0.10161.XA_amd64.deb"
  "https://download.anydesk.com/linux/anydesk_6.1.0-1_amd64.deb"
)

apt_programs=(
  snapd
  git-all
  vim
  inkscape
  gimp
  audacity
  telegram
  ffmpeg
  obs-studio
  simplescreenrecorder
  kdenlive
  guake
)



sudo add-apt-repository ppa:atareao/telegram
sudo add-apt-repository ppa:obsproject/obs-studio
sudo add-apt-repository ppa:kdenlive/kdenlive-stable

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y



## Download e instalaçao de programas externos ##
echo "Instalando programas .deb..."
mkdir "$download_path"
for link in ${deb_links[@]}; do
  wget -c "$link" -P "$download_path"
done

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $download_path/*.deb


# Instalar programas no apt
echo "Instalando programas apt..."
sudo apt-get install -f
for program in ${apt_programs[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$program" -y
  else
    echo "[INSTALADO] - $program"
  fi
done


# Instalar programas no snapd
echo "Instalando programas snapd..."
sudo snap install --classic code
sudo snap install postman
sudo snap install flameshot



# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
