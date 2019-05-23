#!/bin/bash

set -ex

# Heroku cli client
brew install heroku

# Github cli client
brew install hub

# Kubernetes and friends
brew install \
  kubectx kubernetes-cli kube-ps1

# Small utils
brew install \
  jq bat shellcheck

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
export GNUPGHOME="bash /usr/local/opt/asdf/keyrings/nodejs" && mkdir -p "$GNUPGHOME" && chmod 0700 "$GNUPGHOME"
# Imports Node.js release team's OpenPGP keys to the keyring
bash /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring

brew cask install gitup
brew cask install iterm2
brew cask install minikube
brew cask install docker

./install-if-needed.sh