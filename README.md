# dotfiles

Personal dotfiles for Fedora and Arch Linux. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Bootstrap (new machine)

```bash
git clone git@github.com:dustinJ15/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The installer will:
1. Install system packages (`stow`, `fzf`, `zsh`, `git`, `curl`)
2. Install Oh My Zsh
3. Install zsh plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`)
4. Install Starship prompt
5. Prompt you to stow each config package

## Structure

```
dotfiles/
├── nvim/              # LazyVim config  → ~/.config/nvim/
├── tmux/
│   └── .tmux.conf     # tmux config     → ~/.tmux.conf
├── zsh/
│   └── .zshrc         # zsh config      → ~/.zshrc
├── fedora/            # Fedora-specific shell config
├── arch/              # Arch Linux + dwm setup
└── install.sh         # Bootstrap script
```

## Key bindings

### tmux (prefix: `Ctrl+a`)

| Action | Keys |
|---|---|
| Split vertical divider | `Ctrl+a \|` |
| Split horizontal divider | `Ctrl+a -` |
| Navigate panes | `Ctrl+a h/j/k/l` |
| New window | `Ctrl+a c` |
| Next / prev window | `Ctrl+a n` / `p` |
| Kill pane | `Ctrl+a x` |
| Detach | `Ctrl+a d` |

### nvim / LazyVim (leader: `Space`)

| Action | Keys |
|---|---|
| Split vertical divider | `Space \|` |
| Split horizontal divider | `Space -` |
| Navigate windows | `Ctrl+h/j/k/l` |
| Find file | `Space Space` |
| Search in files | `Space /` |

### fzf (shell)

| Action | Keys |
|---|---|
| Fuzzy search history | `Ctrl+r` |
| Fuzzy find file | `Ctrl+t` |
| cd into directory | `Alt+c` |

## Adding a new machine-specific config

Create a new Stow package directory mirroring the home directory structure:

```bash
mkdir -p ~/dotfiles/mypackage
# place files mirroring ~/  e.g. dotfiles/mypackage/.config/foo/bar.conf
stow --dir=~/dotfiles --target=~ mypackage
```
