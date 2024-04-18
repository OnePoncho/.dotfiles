#!/bin/bash

# Essentials
sudo pacman -S --noconfirm \
	zsh \
	git \
	curl \
	wget \
	neovim

# Terminal
sudo pacman -S --noconfirm \
	fd \
	thefuck \
	ripgrep \
	lazygit \
	docker

cd ~/.dotfiles

# Make packages scripts executable
chmod +x ./packages/*.sh

# Other
./packages/oh-my-zsh.sh
./packages/kitty.sh
./packages/fzf.sh
./packages/rust.sh
./packages/cargo.sh
./packages/1password.sh

# Delete zshrc and thefuck/settings.py before creating symlink
if [ test -f ~/.zshrc ]
then
  rm ~/.zshrc
else
  echo ".zshrc does not exist"
fi

if [ test -f ~/.config/thefuck/settings.py ]
then
  rm ~/.config/thefuck/settings.py
else
  echo "settings.py does not exist"
fi


# Change default shell to zsh
chsh -s $(which zsh)
