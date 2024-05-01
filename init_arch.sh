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
	ripgrep \
	lazygit \
	docker

cd ~/.dotfiles

# Make packages scripts executable
chmod +x ./packages/*.sh

# Other
./packages/oh-my-zsh.sh
./packages/zsh-plugins.sh
./packages/kitty.sh
./packages/fzf.sh
./packages/rust.sh
./packages/cargo.sh
./packages/1password.sh
./drivers/nvidia.sh 

# Delete zshrc and thefuck/settings.py before creating symlink
if test -f ~/.zshrc
then
  rm ~/.zshrc
else
  echo ".zshrc does not exist"
fi

# Change default shell to zsh
chsh -s $(which zsh)

echo "CLOSE ALL TERMINALS -> OPEN KITTY -> run 'cargo install dotter'"
