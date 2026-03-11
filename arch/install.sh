#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Arch dotfiles..."

# Symlink home configs
ln -sf "$DOTFILES_DIR/home/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/home/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/home/.xinitrc" ~/.xinitrc
ln -sf "$DOTFILES_DIR/home/.fehbg" ~/.fehbg
ln -sf "$DOTFILES_DIR/home/.gitconfig" ~/.gitconfig

# .config files
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/config/dunst" ~/.config/dunst
ln -sf "$DOTFILES_DIR/config/picom" ~/.config/picom

# Local bin scripts
mkdir -p ~/.local/bin
ln -sf "$DOTFILES_DIR/home/.local/bin/dwm-status" ~/.local/bin/dwm-status
ln -sf "$DOTFILES_DIR/home/.local/bin/hhkb-connect" ~/.local/bin/hhkb-connect

echo "==> Building suckless tools..."
for tool in dwm dmenu st; do
  echo "  Building $tool..."
  cd "$DOTFILES_DIR/src/suckless/$tool"
  make clean install
done

echo "Done!"
