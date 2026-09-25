#!/usr/bin/env bash

apt_programs=(
  flameshot
  inkscape
  gimp
  audacity
  ffmpeg
  simplescreenrecorder
  kdenlive
)

sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
sudo apt update

## Google Chrome (o .deb adiciona o repositório do Google; depois atualiza via apt upgrade) ##
if ! command -v google-chrome &>/dev/null; then
  echo "Instalando Google Chrome..."
  tmpdir=$(mktemp -d)
  wget -q "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O "$tmpdir/chrome.deb"
  sudo apt install -y "$tmpdir/chrome.deb"
  rm -rf "$tmpdir"
else
  echo "[INSTALADO] google-chrome"
fi

## Programas do apt (o apt pula os que já estão instalados) ##
echo "Instalando programas apt..."
sudo apt install -y "${apt_programs[@]}"

## Limpeza ##
sudo apt autoclean
sudo apt autoremove -y
