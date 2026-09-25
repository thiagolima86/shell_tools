#!/usr/bin/env bash

apt_programs=(
  # desktop
  flameshot
  inkscape
  gimp
  audacity
  simplescreenrecorder
  kdenlive
  handbrake
  vlc
  gparted
  keepassxc
  # terminal
  ffmpeg
  htop
  btop
  ncdu
  jq
  ripgrep
  fzf
  bat
  tree
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

## lazydocker (script oficial; instala em ~/.local/bin) ##
if ! command -v lazydocker &>/dev/null && [ ! -x "$HOME/.local/bin/lazydocker" ]; then
  echo "Instalando lazydocker..."
  curl -fsSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
  echo "[INSTALADO] lazydocker"
fi

## Limpeza ##
sudo apt autoclean
sudo apt autoremove -y
