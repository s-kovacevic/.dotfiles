#!/bin/bash
# Repository must be cloned to ~ directory since links are created with the absolute path
# shell/.secrets file must be created and populated before running this script
mkdir -p ~/.local/config
ln -sfh ~/.dotfiles/nvim/ ~/.config/nvim
ln -sfh ~/.dotfiles/alacritty/ ~/.config/alacritty
ln -sfh ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -sfh ~/.dotfiles/shell/.secrets ~/.secrets
ln -sfh ~/.dotfiles/shell/.profile ~/.profile
ln -sfh ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.local/scripts
ln -sfh ~/.dotfiles/scripts/tmux-sessionizer ~/.local/scripts/tmux-sessionizer
ln -sfh ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sfh ~/.dotfiles/git/.gitignore ~/.gitignore
