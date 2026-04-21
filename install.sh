#!/bin/bash

# --- Colors for pretty output ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Modular Dotfiles Installer${NC}"

# Detect OS
if [ -f /etc/fedora-release ]; then
    OS="fedora"
elif [ -f /etc/arch-release ]; then
    OS="arch"
else
    OS="unknown"
fi

echo -e "Detected OS: ${YELLOW}$OS${NC}"

# Function to handle symlinking
link_config() {
    local src=$1
    local dest=$2
    local name=$3

    read -p "Do you want to install $name config? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$(dirname "$dest")"
        if [ -L "$dest" ]; then
            echo -e "  🔗 ${GREEN}Link already exists for $name${NC}"
        elif [ -e "$dest" ]; then
            echo -e "  📦 ${YELLOW}Backing up existing $name config to ${dest}.bak${NC}"
            mv "$dest" "${dest}.bak"
            ln -s "$src" "$dest"
        else
            echo -e "  ✨ ${GREEN}Linking $name config${NC}"
            ln -s "$src" "$dest"
        fi
    fi
}

# --- Core Modules ---
link_config "$HOME/dotfiles/nvim" "$HOME/.config/nvim" "Neovim (LazyVim)"
link_config "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf" "tmux"

# --- OS Specific Modules ---
if [ "$OS" == "fedora" ]; then
    link_config "$HOME/dotfiles/fedora/home/.bashrc" "$HOME/.bashrc" "Fedora Bashrc"
elif [ "$OS" == "arch" ]; then
    link_config "$HOME/dotfiles/arch/home/.bashrc" "$HOME/.bashrc" "Arch Bashrc"
fi

echo -e "${BLUE}✅ Installation finished!${NC}"
