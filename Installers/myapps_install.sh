#!/usr/bin/env bash

download_path="$HOME/Downloads/programas"

deb_links=(
  "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
)

apt_programs=(
  flameshot
  vim
  inkscape
  gimp
  audacity
  ffmpeg
  simplescreenrecorder
  kdenlive
)



sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y

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
  if ! dpkg -s "$program" &>/dev/null; then # Só instala se já não estiver instalado
    sudo apt install "$program" -y
  else
    echo "[INSTALADO] - $program"
  fi
done



# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
