#!/bin/bash

# Create plugins directory and clone plugin repos
echo "Creating plugins directory"
mkdir sudo ~/.dotfiles/zsh/plugins & process_id=$!
wait $process_id

if test -d ~/.dotfiles/zsh/plugins
then
  echo "Directory Created"
  echo "Cloning plugins"
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.dotfiles/zsh/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-completions ~/.dotfiles/zsh/plugins/zsh-completions
else
  echo "Plugins directory does not exist, no plugins installed"
fi
