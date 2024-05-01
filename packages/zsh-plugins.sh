#!/bin/bash

# Create plugins directory and clone plugin repos
echo "Creating plugins directory"
mkdir ../zsh/plugins & process_id=$!
wait $process_id

if test -d ../zsh/plugins
then
  echo "Directory Created"
  echo "Cloning plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions ../zsh/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ../zsh/plugins/zsh-completions
else
  echo "Plugins directory does not exist, no plugins installed"
fi
