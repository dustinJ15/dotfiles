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
└── fedora/      # Fedora Workstation + GNOME setup
    ├── config/  # systemd user services
    ├── home/    # .bashrc, .gitconfig
    └── install.sh
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

## Arch Dependencies

- JetBrainsMono Nerd Font
- picom (compositor)
- dunst (notifications)
- feh (wallpaper)
- maim, xclip (screenshots)
- pactl (volume)
- playerctl (media)
