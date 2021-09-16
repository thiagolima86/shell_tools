#!/usr/bin/env bash

sudo apt-get update && apt-get install -qq -y --no-install-recommends \
autoconf bison build-essential \
libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev \
libffi-dev libgdbm5 libgdbm-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build