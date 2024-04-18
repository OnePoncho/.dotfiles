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
./packages/1password.sh

# Delete zshrc and thefuck/settings.py before creating symlink
rm /home/eduardo/.zshrc
rm /home/eduardo/.config/thefuck/settings.py

