#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Fedora dotfiles..."

# Symlink home configs
ln -sf "$DOTFILES_DIR/home/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/home/.bashrc" ~/.bashrc

# Systemd user service for rclone Google Drive mount
mkdir -p ~/.config/systemd/user
ln -sf "$DOTFILES_DIR/config/systemd/user/rclone-gdrive.service" ~/.config/systemd/user/rclone-gdrive.service

echo "==> Installing packages..."
sudo dnf install -y \
  git gh rclone fuse3 \
  nodejs java-21-openjdk java-21-openjdk-devel \
  @development-tools @c-development \
  lm_sensors

echo "==> Installing RPM Fusion..."
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

echo "==> Enabling Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "==> Installing Flatpaks..."
flatpak install -y flathub com.vscodium.codium

echo "==> Setting up Google Drive mount directory..."
mkdir -p ~/google-drive

echo "==> Enabling rclone systemd service..."
systemctl --user daemon-reload
systemctl --user enable rclone-gdrive.service

echo ""
echo "Done! Remaining manual steps:"
echo "  1. Set up SSH key: ssh-keygen -t ed25519 -C 'your@email.com'"
echo "  2. Add key to GitHub: https://github.com/settings/keys"
echo "  3. Configure rclone Google Drive: rclone config"
echo "  4. Run: systemctl --user start rclone-gdrive.service"
