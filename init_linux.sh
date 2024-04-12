#!/bin/bash


apt update && apt upgrade


# essentials
apt install -y \
	zsh \
	git \
	curl \
	wget \
	nvim




# Terminal
apt install -y \
	fd-find \
	thefuck \
	ripgrep
	


# other
./packages/oh-my-zsh.sh
./packages/fzf.sh
./packages/rust.sh
./packages/neovim.sh
