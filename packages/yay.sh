#!/bin/bash
 
#install yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si

#update AUR
yay
