#!/bin/bash

git clone https://aur.archlinux.org/visual-studio-code-bin.git ~/visual-studio-code-bin
cd visual-studio-code-bin
makepkg -si
