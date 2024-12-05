#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

SSH_KEY="$HOME/.ssh/personal"
ssh-keygen -t ed25519 -C "baskski@gmail.com" -f "$SSH_KEY" -N ''
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$SSH_KEY"
pbcopy <"$SSH_KEY.pub"
echo "Copied ssh public key from location $SSH_KEY to clipboard. Please add it to GitHub..."
while true; do
  read -r -p "Done? [y/n] " -n 1
  echo
  case "$REPLY" in
  y | Y) break ;;
  n | N) exit 1 ;;
  *) echo "Invalid input" ;;
  esac
done

git clone --bare git@github.com:cecobask/dot.git "$HOME/.dot"
alias dot='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no
ssh -T git@github.com || { echo 'Ensure your public key has been added to GitHub...'; exit 1; }

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/HEAD/binscripts/gvm-installer)
source "$HOME/.gvm/scripts/gvm"
gvm install go1.23.2 -B
gvm use go1.23.2 --default

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install v18.20.4
nvm use v18.20.4

pyenv install 3.13.0
pyenv global 3.13.0

mkdir -p "$HOME/repos-personal" "$HOME/repos-work"