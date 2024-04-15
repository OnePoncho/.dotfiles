#!bin/bash

#install yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#update AUR
yay

# Essentials
pacman -S --noconfirm \
	zsh \
	git \
	curl \
	wget \
	neovim


# Terminal
pacman -S --noconfirm \
	fd \
	thefuck \
	ripgrep \
  lazygit

# Configure thefuck
fuck
fuck
source ~/.bashrc

# Make packages scripts executable
chmod +x ./packages/*.sh

# Other
./packages/oh-my-zsh.sh
./packages/kitty.sh
./packages/fzf.sh
./packages/rust.sh

# Delete zshrc and thefuck/settings.py before creating symlink
rm /home/eduardo/.zshrc
rm /home/eduardo/.config/thefuck/settings.py

# Run Dotter
dotter deploy
