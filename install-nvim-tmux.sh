#!/bin/bash

# Define paths
DOTFILES_DIR=~/dotfiles

echo "🚀 Starting Dotfiles installation..."

# Create config directory if it doesn't exist
mkdir -p ~/.config

# Function to create symlinks
link_file() {
    local src=$1
    local dest=$2
    
    if [ -L "$dest" ]; then
        echo "🔗 Link for $dest already exists, skipping..."
    elif [ -e "$dest" ]; then
        echo "📦 Found existing $dest, backing up to ${dest}.bak"
        mv "$dest" "${dest}.bak"
        ln -s "$src" "$dest"
    else
        echo "✨ Creating new link for $dest"
        ln -s "$src" "$dest"
    fi
}

# Link configurations
link_file "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "✅ Installation complete! Remember to install JetBrainsMono Nerd Font."
