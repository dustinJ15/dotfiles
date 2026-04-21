# dotfiles

Personal dotfiles for Arch Linux and Fedora Workstation.

## Structure

```
dotfiles/
├── arch/        # Arch Linux + dwm setup
│   ├── config/  # dunst, picom (Gruvbox themed)
│   ├── home/    # .bashrc, .xinitrc, .gitconfig, etc.
│   ├── src/     # suckless builds (dwm, st, dmenu)
│   └── install.sh
├── fedora/      # Fedora Workstation + GNOME setup
│   ├── config/  # systemd user services
│   ├── home/    # .bashrc, .gitconfig
│   └── install.sh
├── nvim/        # LazyVim Neovim configuration
├── tmux.conf    # Pro tmux configuration (Ctrl+a prefix)
└── install-nvim-tmux.sh # Installer for Neovim/tmux
```

## Usage

### Fedora
```bash
git clone git@github.com:dustinJ15/dotfiles.git ~/dotfiles
cd ~/dotfiles/fedora
chmod +x install.sh
./install.sh
```

### Arch
```bash
git clone git@github.com:dustinJ15/dotfiles.git ~/dotfiles
cd ~/dotfiles/arch
chmod +x install.sh
./install.sh
```

### Neovim & tmux (Cross-platform)
```bash
cd ~/dotfiles
chmod +x install-nvim-tmux.sh
./install-nvim-tmux.sh
```

## Arch Dependencies

- JetBrainsMono Nerd Font
- picom (compositor)
- dunst (notifications)
- feh (wallpaper)
- maim, xclip (screenshots)
- pactl (volume)
- playerctl (media)

## Neovim & tmux Setup

### 🛠️ Included Tools
- **Neovim:** Powered by [LazyVim](https://www.lazyvim.org/)
- **tmux:** Optimized for productivity with `Ctrl+a` prefix and mouse support
- **Font:** JetBrainsMono Nerd Font (Required to see icons properly)

### ⌨️ Quick Shortcuts
- **tmux Prefix:** `Ctrl+a`
- **tmux Vertical Split:** `Prefix + |`
- **tmux Horizontal Split:** `Prefix + -`
- **LazyVim Leader:** `Space`
