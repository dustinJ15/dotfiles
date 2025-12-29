# dotfiles

My Arch Linux configuration files.

## Structure

```
├── suckless/
│   ├── dwm/    # Dynamic window manager (Gruvbox theme)
│   ├── st/     # Simple terminal
│   └── dmenu/  # Application launcher
├── scripts/
│   ├── dwm-status    # Status bar script
│   └── hhkb-connect  # HHKB keyboard setup
├── .xinitrc          # X11 startup (HiDPI, mouse, touchpad)
└── shell configs (.bashrc, .bash_profile)
```

## Installation

```bash
# Clone the repo
git clone https://github.com/dustinJ15/dotfiles.git
cd dotfiles

# Install suckless tools
cd suckless/dwm && sudo make clean install && cd ../..
cd suckless/st && sudo make clean install && cd ../..
cd suckless/dmenu && sudo make clean install && cd ../..

# Copy configs
cp .bashrc .bash_profile .gitconfig .fehbg .xinitrc ~/
mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/
```

## Dependencies

- JetBrainsMono Nerd Font
- feh (wallpaper)
- maim, xclip (screenshots)
- pactl (volume)
- playerctl (media)
