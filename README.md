# dotfiles

My Arch Linux configuration files.

## Structure

```
dotfiles/
├── home/                   # Symlink contents to ~/
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .gitconfig
│   ├── .fehbg
│   ├── .xinitrc
│   └── .local/bin/
│       ├── dwm-status      # Status bar script
│       └── hhkb-connect    # HHKB keyboard setup
├── config/                 # Symlink contents to ~/.config/
│   ├── picom/              # Compositor (Gruvbox themed)
│   └── dunst/              # Notifications (Gruvbox themed)
└── src/                    # Compiled programs
    └── suckless/
        ├── dwm/            # Dynamic window manager
        ├── st/             # Simple terminal
        └── dmenu/          # Application launcher
```

## Installation

```bash
# Clone the repo
git clone https://github.com/dustinJ15/dotfiles.git
cd dotfiles

# Install suckless tools
cd src/suckless/dwm && sudo make clean install && cd ../../..
cd src/suckless/st && sudo make clean install && cd ../../..
cd src/suckless/dmenu && sudo make clean install && cd ../../..

# Symlink home dotfiles
ln -sf $(pwd)/home/.bashrc ~/
ln -sf $(pwd)/home/.bash_profile ~/
ln -sf $(pwd)/home/.gitconfig ~/
ln -sf $(pwd)/home/.fehbg ~/
ln -sf $(pwd)/home/.xinitrc ~/
mkdir -p ~/.local/bin
ln -sf $(pwd)/home/.local/bin/* ~/.local/bin/

# Symlink configs
mkdir -p ~/.config
ln -sf $(pwd)/config/picom ~/.config/
ln -sf $(pwd)/config/dunst ~/.config/
```

## Dependencies

- JetBrainsMono Nerd Font
- picom (compositor)
- dunst (notifications)
- feh (wallpaper)
- maim, xclip (screenshots)
- pactl (volume)
- playerctl (media)
