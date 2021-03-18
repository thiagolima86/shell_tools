#!/usr/bin/env bash

sudo apt install zsh -y

whereis zsh

sudo usermod -s /usr/bin/zsh $(whoami)

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#configurar arquivo aliases

script_aliases="

#include bash aliase file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
"

touch "$HOME/.bash_aliases"

echo "$script_aliases" >> "$HOME/.zshrc"
echo "$script_aliases" >> "$HOME/.bashrc"

source ~/.zshrc 
