# Starship ----------------------------------------
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Install Homebrew -------------------------------
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# fzf extras ----------------------------------------
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Setting nvim as default editor ----------------------------------------
if [ $(command -v nvim) ]; then
  export EDITOR=$(which nvim)
  alias vim=$EDITOR
  alias v=$EDITOR
fi

export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

# Python
export PATH="${PATH}:/Users/devindelaney/Library/Python/3.11/lib/python/site-packages"

# Colored manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Aliases

# alias ll="eza -l --icons --git -a"
alias ll="lsd -l --git"
# alias ls="eza --color=always --grid --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ls="lsd --git"
# alias la="eza -a"
alias la="lsd -a"
# alias lt="eza --tree --level=2 --long --icons --git"
alias lt="lsd --tree --depth=2 --long --git"
alias vimm="vim"
alias x="exit"
alias gn="sudo shutdown -h now"
# alias lt="ls -hT --color=always"
alias cat="bat"
alias z="zoxide"
alias sv="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias ya="yazi"
alias d="delta"
alias yt="yt-dlp"
alias fetch="neofetch"
alias sp="spotify_player"
alias wifi="wifi-password"
alias py="python3"
alias rm="trash"
alias ping="ping -c 5"

# Nmap
alias nm="nmap -sC -sV -oN nmap-output.txt"

#git aliases

alias ga='git add -A'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gdiff='git diff'
alias gdc='git diff --cached'
alias gcm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull'
alias gcl='git clone'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# VI Mode!!!
bindkey jj vi-cmd-mode

#Create a directory and cd diretctly into it
function take {
    mkdir -p $1
    cd $1
}

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
