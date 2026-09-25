#!/usr/bin/env bash

sudo apt update
sudo apt install -y zsh curl git

# shell padrão
zsh_path="$(command -v zsh)"
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$zsh_path" ]; then
  sudo usermod -s "$zsh_path" "$USER"
  echo "Shell padrão alterado para zsh. Faça logout/login para aplicar."
else
  echo "[OK] zsh já é o shell padrão"
fi

# --unattended: não troca o shell nem abre o zsh no fim (a troca já foi feita acima)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[INSTALADO] oh-my-zsh"
fi

# carrega ~/.bash_aliases no zsh (o .bashrc padrão já faz isso)
touch "$HOME/.bash_aliases"
if ! grep -q 'bash_aliases' "$HOME/.zshrc"; then
  cat >> "$HOME/.zshrc" <<'EOF'

# include bash aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
fi
