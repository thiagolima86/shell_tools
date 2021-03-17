#!/usr/bin/env bash

sudo apt install zsh -y

whereis zsh

sudo usermod -s /usr/bin/zsh $(whoami)

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#configurar arquivo aliases

script_aliases = "\n
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
"

echo "$script_aliases" >> "$HOME/.zshrc"
echo "$script_aliases" >> "$HOME/.bashrc"
source ~/.bashrc
source ~/.zshrc 