#!/usr/bin/env bash

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "[INSTALADO] oh-my-zsh"
  exit 0
fi

sudo apt update
sudo apt install -y zsh curl git

sudo usermod -s "$(command -v zsh)" "$USER"

# --unattended: não troca o shell nem abre o zsh no fim (a troca já foi feita acima)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# carrega ~/.bash_aliases no zsh (o .bashrc padrão do Ubuntu já faz isso)
touch "$HOME/.bash_aliases"
if ! grep -q 'bash_aliases' "$HOME/.zshrc"; then
  cat >> "$HOME/.zshrc" <<'EOF'

# include bash aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
fi

echo "Oh My Zsh instalado. Faça logout/login para usar o zsh como shell padrão."
