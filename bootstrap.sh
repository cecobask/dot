#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

SSH_DIR="$HOME/.ssh"
SSH_KEY="$SSH_DIR/personal"
SSH_CONFIG="$SSH_DIR/config"
ssh-keygen -t ed25519 -C "baskski@gmail.com" -f "$SSH_KEY" -N ''
eval "$(ssh-agent -s)"
cat <<EOF >"$SSH_CONFIG"
Host github-personal
Hostname github.com
AddKeysToAgent yes
IdentityFile $SSH_KEY
IdentitiesOnly yes
EOF
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
ssh -T git@github.com

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
git clone --bare git@github.com:cecobask/dot.git "$HOME/.dot"
alias dot='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no
