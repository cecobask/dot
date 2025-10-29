export ZSH="$ZDOTDIR/.oh-my-zsh"
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
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export K9S_CONFIG_DIR="$XDG_CONFIG_HOME/k9s"

export PATH="$PATH:$HOME/.rd/bin"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$PATH:$HOME/.codeium/windsurf/bin"

eval "$(direnv hook zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"

