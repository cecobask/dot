#!/usr/bin/env bash

set -e
set -o pipefail
set -u

if ! command -v brew >/dev/null 2>&1; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "skipped installing brew as it already exists"
fi

curl -fsSL https://raw.githubusercontent.com/cecobask/dot/refs/heads/main/Brewfile | brew bundle install --file=-

SSH_PRIVATE_KEY="$HOME/.ssh/id_ed25519"
if [[ ! -f "$SSH_PRIVATE_KEY" ]]; then
	mkdir -p "$HOME/.ssh"
	ssh-keygen -t ed25519 -C "baskski@gmail.com" -f "$SSH_PRIVATE_KEY" -N ''
	eval "$(ssh-agent -s)"
	ssh-add --apple-use-keychain "$SSH_PRIVATE_KEY"
else
	echo "skipped creating ssh key as it already exists"
fi

gh auth login \
	--hostname=github.com \
	--git-protocol=ssh \
	--skip-ssh-key \
	--scopes=admin:public_key,admin:ssh_signing_key \
	--web \
	--clipboard
SSH_PUBLIC_KEY="$SSH_PRIVATE_KEY.pub"
SERIAL_NUM=$(ioreg -ard1 -c IOPlatformExpertDevice | plutil -extract 0.IOPlatformSerialNumber raw -)
gh ssh-key add "$SSH_PUBLIC_KEY" --type=authentication --title="$SERIAL_NUM"
gh ssh-key add "$SSH_PUBLIC_KEY" --type=signing --title="$SERIAL_NUM"

DOT_DIR="$HOME/.dot"
if [[ ! -d "$DOT_DIR" ]]; then
	git clone --bare git@github.com:cecobask/dot.git "$DOT_DIR"
else
	echo "skipped cloning dot repo as it already exists"
fi
alias dot='git --git-dir=$DOT_DIR --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no

if ! command -v omz >/dev/null 2>&1; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)" "" --unattended --keep-zshrc
else
	echo "skipped installing omz as it already exists"
fi

echo "bootstrap completed successfully"
