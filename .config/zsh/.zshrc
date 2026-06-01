export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 28
HIST_STAMPS="%Y-%m-%dT%H:%M:%S%z"
plugins=(git)
source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"
source <(fzf --zsh)
export EDITOR=vim VISUAL=vim
alias dot='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

export K9S_CONFIG_DIR="$XDG_CONFIG_HOME/k9s"

eval "$(direnv hook zsh)"
