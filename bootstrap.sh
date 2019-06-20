#!/bin/bash

set -ex

# Utils
brew install \
  jq bat shellcheck heroku hub autojump

# Asdf and friends
# Maybe need to run
# echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
# echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
brew install \
  asdf coreutils automake autoconf openssl \
  libyaml readline libxslt libtool unixodbc \
  unzip curl gpg

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

# One does not simply manage nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Imports Node.js release team's OpenPGP keys to the keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Apps
brew cask install \
  gitup \
  iterm2 \
  docker \

./install-if-needed.sh