# dotfiles

My Arch Linux configuration files.

## What's included

- **dwm** - Dynamic window manager (suckless) with Gruvbox theme
- **st** - Simple terminal (suckless)
- **dmenu** - Application launcher (suckless)
- **dwm-status** - Custom status bar script
- Shell configs (`.bashrc`, `.bash_profile`)

## Installation

```bash
# Clone the repo
git clone https://github.com/dustinJ15/dotfiles.git
cd dotfiles

# Install suckless tools
cd dwm && sudo make clean install && cd ..
cd st && sudo make clean install && cd ..
cd dmenu && sudo make clean install && cd ..

# Copy configs
cp .bashrc .bash_profile .gitconfig .fehbg ~/
mkdir -p ~/.local/bin
cp .local/bin/dwm-status ~/.local/bin/
```

## Dependencies

- JetBrainsMono Nerd Font
- feh (wallpaper)
- maim, xclip (screenshots)
- pactl (volume)
- playerctl (media)
