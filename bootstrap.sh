#!/bin/bash

set -ex

# Heroku cli client
brew install heroku

# Github cli client
brew install hub

# Kubernetes and friends
brew install \
  kubectx kubernetes-cli kube-ps1

# Asdf and friends
# Maybe need to run
# echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
# echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
brew install \
  asdf coreutils automake autoconf openssl \
  libyaml readline libxslt libtool unixodbc \
  unzip curl

brew cask install gitup
brew cask install iterm2
brew cask install minikube
brew cask install docker
