#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES="$HOME/dotfiles"

echo -e "${BLUE}Starting dotfiles installer${NC}"

# --- Detect OS and environment ---
if [ -f /etc/fedora-release ]; then
    OS="fedora"
elif [ -f /etc/arch-release ]; then
    OS="arch"
elif [ -f /etc/debian_version ]; then
    OS="debian"
else
    OS="unknown"
fi

# Headless if no display server
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    HEADLESS=true
else
    HEADLESS=false
fi

echo -e "Detected OS: ${YELLOW}$OS${NC}"

# --- Install system packages ---
install_packages() {
    echo -e "\n${BLUE}Installing system packages...${NC}"
    if [ "$OS" == "fedora" ]; then
        sudo dnf install -y stow fzf zsh git curl foot ax86-terminus-ttf-fonts
    elif [ "$OS" == "arch" ]; then
        sudo pacman -S --noconfirm stow fzf zsh git curl foot
    elif [ "$OS" == "debian" ]; then
        sudo apt-get install -y stow fzf zsh git curl tmux neovim
    else
        echo -e "${YELLOW}Unknown OS — install stow, fzf, zsh, git, curl manually${NC}"
    fi
}

# --- Install Oh My Zsh ---
install_omz() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "\n${BLUE}Installing Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo -e "${GREEN}Oh My Zsh already installed${NC}"
    fi
}

# --- Install zsh plugins ---
install_zsh_plugins() {
    echo -e "\n${BLUE}Installing zsh plugins...${NC}"
    local plugins_dir="$HOME/.oh-my-zsh/custom/plugins"

    if [ ! -d "$plugins_dir/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
    else
        echo -e "${GREEN}zsh-autosuggestions already installed${NC}"
    fi

    if [ ! -d "$plugins_dir/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugins_dir/zsh-syntax-highlighting"
    else
        echo -e "${GREEN}zsh-syntax-highlighting already installed${NC}"
    fi
}

# --- Install Starship ---
install_starship() {
    if ! command -v starship &>/dev/null; then
        echo -e "\n${BLUE}Installing Starship...${NC}"
        mkdir -p "$HOME/.local/bin"
        curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
    else
        echo -e "${GREEN}Starship already installed${NC}"
    fi
}

# --- Stow a package ---
stow_package() {
    local package=$1
    local target=${2:-$HOME}
    local name=${3:-$package}

    read -p "Install $name config? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$target"
        stow --dir="$DOTFILES" --target="$target" --restow "$package" \
            && echo -e "  ${GREEN}Linked $name${NC}" \
            || echo -e "  ${RED}Stow conflict for $name — resolve manually${NC}"
    fi
}

# --- Run ---
install_packages
install_omz
install_zsh_plugins
install_starship

echo -e "\n${BLUE}Linking configs...${NC}"
stow_package nvim "$HOME/.config" "Neovim (LazyVim)"
stow_package tmux "$HOME" "tmux"
stow_package zsh "$HOME" "zsh"

if [ "$HEADLESS" = false ]; then
    stow_package foot "$HOME" "foot terminal"
    stow_package fontconfig "$HOME" "fontconfig (Terminus bitmap rendering)"
fi

if [ "$OS" == "fedora" ]; then
    stow_package fedora "$HOME" "Fedora shell config"
elif [ "$OS" == "arch" ]; then
    stow_package arch "$HOME" "Arch shell config"
fi

# --- GNOME keybindings ---
setup_gnome_keybindings() {
    if ! command -v gsettings &>/dev/null; then
        echo -e "${YELLOW}gsettings not found, skipping GNOME keybindings${NC}"
        return
    fi

    echo -e "\n${BLUE}Setting GNOME custom keybindings...${NC}"

    local base="org.gnome.settings-daemon.plugins.media-keys"
    local path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

    gsettings set $base custom-keybindings \
        "['$path/custom0/', '$path/custom1/']"

    # Super+Enter → foot (opens in last used directory)
    gsettings set $base.custom-keybinding:$path/custom0/ name    'foot'
    gsettings set $base.custom-keybinding:$path/custom0/ command 'bash -c "foot --working-directory=\"\$(cat \$HOME/.local/share/foot/cwd 2>/dev/null || echo \$HOME)\""'
    gsettings set $base.custom-keybinding:$path/custom0/ binding '<Super>Return'

    # Super+b → Firefox new window
    gsettings set $base.custom-keybinding:$path/custom1/ name    'New Firefox Tab'
    gsettings set $base.custom-keybinding:$path/custom1/ command 'firefox --new-window'
    gsettings set $base.custom-keybinding:$path/custom1/ binding '<Super>b'

    echo -e "  ${GREEN}GNOME keybindings set${NC}"
}

if [ "$HEADLESS" = false ]; then
    setup_gnome_keybindings
fi

echo -e "\n${BLUE}Done. Open a new shell to see changes.${NC}"
