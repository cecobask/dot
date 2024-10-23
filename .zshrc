export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 28
HIST_STAMPS="%Y-%m-%dT%H:%M:%S%z"
plugins=(
    git
)
source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"
source <(fzf --zsh)
export EDITOR=vim VISUAL=vim
alias dot='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
[[ -s "/Users/tdimov/.gvm/scripts/gvm" ]] && source "/Users/tdimov/.gvm/scripts/gvm"
export PATH="$PATH:$HOME/scripts/jetbrains"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
