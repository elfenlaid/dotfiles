# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  gitignore
  heroku
  mix
  stack
  pod
  bundler
  asdf
  docker
  autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias l='ls -lFh'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias h='history'
alias hgrep='fc -El 0 | grep'

alias w='cd ~/Work'
alias c='cd ~/Code'
alias d='cd ~/Downloads'

mcd () { mkdir -p -- "$1" && cd -P -- "$1" }

# Launch only one ssh-agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# asdf cflags for buggy python installations
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

# Elixir & Erlang repl history
export ERL_AFLAGS="-kernel shell_history enabled"

# Visual Studio Code custom launch command to keep up with zsh PATH
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
alias e='code .'

# Docker PostgreSQL
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

alias docker-stop-all='docker container stop $(docker container ls -q)'
alias docker-clean-all='docker container rm $(docker container ls -q)'

# Jupyter docker
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

# Jekyll
alias bekyll="bundle exec jekyll serve --drafts"
alias draft="bundle exec jekyll draft"

# Kubernetes
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT

source <(kubectl completion zsh)

alias k='kubectl'
alias klog='kubectl logs -f -p'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kdp='kubectl describe pods'

# Google cloud completions
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
