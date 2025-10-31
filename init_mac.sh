#!/bin/bash

brew install \
	zsh \
	git \
	curl \
	wget \
	ripgrep \
	docker \
	lazygit \
	lazydocker \

brew install --cask \
  aerospace \
  bitwarden \
  db-browser-for-sqlite \
  discord \
  ghostty \
  grandperspective \
  hammerspoon \
  iina
 
brew install --cask \
  joplin \
  mullvad-vpn \
  orbstack \
  postman \
  visual-studio-code \
  vivaldi
  #google-chrome \
  #gstreamer-runtime \

cd ~/.dotfiles

# Make packages scripts executable
chmod +x ./packages/*.sh

# Other
./packages/oh-my-zsh.sh
./packages/zsh-plugins.sh
./packages/fzf.sh
./packages/rust.sh
./packages/cargo.sh
./packages/docker-compose.sh
./packages/1password.sh
./packages/vscode.sh
./packages/discord.sh

# Delete zshrc and thefuck/settings.py before creating symlink
if test -f ~/.zshrc
then
  rm ~/.zshrc
else
  echo ".zshrc does not exist"
fi

# Change default shell to zsh
chsh -s $(which zsh)

echo "Complete"
