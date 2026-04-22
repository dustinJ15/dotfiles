#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES="$HOME/dotfiles"

echo -e "${BLUE}Starting dotfiles installer${NC}"

if [ -f /etc/fedora-release ]; then
    OS="fedora"
elif [ -f /etc/arch-release ]; then
    OS="arch"
else
    OS="unknown"
fi

echo -e "Detected OS: ${YELLOW}$OS${NC}"

stow_package() {
    local package=$1
    local target=${2:-$HOME}
    local name=${3:-$package}

    read -p "Install $name config? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$target"
        stow --dir="$DOTFILES" --target="$target" "$package" \
            && echo -e "  ${GREEN}Linked $name${NC}" \
            || echo -e "  ${YELLOW}Stow conflict for $name — resolve manually${NC}"
    fi
}

# Core
stow_package nvim "$HOME/.config" "Neovim (LazyVim)"
stow_package tmux "$HOME" "tmux"
stow_package zsh "$HOME" "zsh"

# OS specific
if [ "$OS" == "fedora" ]; then
    stow_package fedora "$HOME" "Fedora shell config"
elif [ "$OS" == "arch" ]; then
    stow_package arch "$HOME" "Arch shell config"
fi

echo -e "${BLUE}Done${NC}"
