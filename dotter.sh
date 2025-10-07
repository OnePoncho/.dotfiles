#!/bin/bash

# syntax - file/dir that already exists -- where you want it to go
ln -sf ~/dotfiles/zsh/plugins ~/.oh-my-zsh/custom
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc 
ln -sf ~/dotfiles/ghostty ~/.config
ln -sf ~/dotfiles/nvim ~/.config
ln -sf ~/dotfiles/hammerspoon ~/.hammerspoon
ln -sf ~/dotfiles/aerospace/aerospace.toml ~/.aerospace.toml

# Fonts only for Arch
#ln -sf ~/dotfiles/fonts ~/.local/share


