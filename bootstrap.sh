#!/bin/bash

set -ex

# Utils
brew install \
  jq bat shellcheck autojump gh

# Asdf and friends
# Maybe need to run
# echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
# echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
brew install \
  asdf coreutils automake autoconf openssl \
  libyaml readline libxslt libtool unixodbc \
  unzip curl gpg rbenv

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

# One does not simply manage nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Imports Node.js release team's OpenPGP keys to the keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Presetup zsh-highlights
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Apps
brew cask install \
  gitup \
  iterm2 \
  docker \

./install-if-needed.sh

# Create default directories
mkdir -p ~/Code || true
mkdir -p ~/Work || true
mkdir -p ~/.ssh || true
