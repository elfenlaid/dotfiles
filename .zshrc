# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/elfenlaid/.oh-my-zsh"

# Use UTF as default language
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Command execution time stamp shown in the history command output.
HIST_STAMPS="dd-mm-yyyy"

# Which plugins would you like to load?
plugins=(
  mix
  bundler
  autojump
)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias l='ls -lFh'

alias w='cd ~/Work'
alias c='cd ~/Code'
alias d='cd ~/Downloads'

alias gs='git status --short --branch'
alias gd='git diff'
alias gc='git checkout'
alias gb='git checkout -b'
alias gm='git checkout master'
alias gp='git pull'
alias gpm='git push origin master'
alias gri='git rebase -i master'
alias trim='git branch | grep -v "\*" | xargs -n 1 git branch -D;'

mcd () { mkdir -p -- "$1" && cd -P -- "$1" }

alias bfg='be fastlane gen'

# Launch only one ssh-agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add -A &>/dev/null

# asdf cflags for buggy python installations
export CFLAGS="-O2 -g -fno-stack-check -I$(xcrun --show-sdk-path)/usr/include"

# Elixir & Erlang repl history
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_CONFIGURE_OPTIONS="--disable-hipe --without-javac --with-ssl=/usr/local/opt/openssl@1.1"
export KERL_BUILD_DOCS=yes

# Visual Studio Code custom launch command to keep up with zsh PATH
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
alias e='code .'

# Docker
alias docker-stop-all='docker container stop $(docker container ls -q)'
alias docker-clean-all='docker container rm $(docker container ls -q)'

# PostgreSQL Docker
pg-start() {
  # --rm Automatically remove the container and it’s associated file system upon exit
  # -d Launch container in backgroind
  # -e Set containers env vars
  # -p Bing the host machine port with container's port
  # -v Mount volume on the host machine to the container volume
  docker run \
    --rm \
    -d \
    --name pg-docker \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_USER=postgres \
    -p 5432:5432 \
    -v ~/docker/volumes/postgres:/var/lib/postgresql/data \
    postgres
}
pg-stop() { docker stop pg-docker }
pg-psql() { docker exec -it pg-docker psql -U postgres $* }
pg-pg_dump() { docker exec -it pg-docker pg_dump }

# Jupyter Docker
dupyter() {
  docker run \
    --rm \
    -p 8888:8888 \
    -e JUPYTER_ENABLE_LAB=yes \
    -v "$PWD":/home/jovyan/ \
    jupyter/datascience-notebook
}

# Working with Github
pull-request() {
    local BRANCH=$(git rev-parse --abbrev-ref HEAD)
    local MESSAGE=$(git log --pretty=format:'%s' --date=relative master.."${BRANCH}" | tail -1)
    echo "Creating pull request with message: ${MESSAGE}"

    git push -u origin "${BRANCH}"
    hub pull-request -m "${MESSAGE}"
}

alias cpr="pull-request"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Ruby shenenigans
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" || true

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
