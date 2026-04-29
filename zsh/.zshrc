# Auto-start tmux
if [ -z "$TMUX" ]; then
    exec tmux new-session -A -s main
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""  # disabled in favour of starship

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$HOME/.local/bin:$HOME/.claude/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias claw="ssh -t debian 'sudo -u claw node /home/claw/OpenClaw/dist/index.js tui'"

# AI toolchain
export PATH="$HOME/.npm-global/bin:$HOME/.opencode/bin:$PATH"
export OLLAMA_HOST=http://localhost:11434
export OLLAMA_API_BASE=http://localhost:11434
[[ -d /usr/local/cuda ]] && {
    export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
}

# chat <shortcode> to chat with an ollama model, or just `chat` for a picker
function chat() {
  local -A models=(
    [q3]="qwen3:32b-q4_K_M"
    [q3c]="qwen3-coder:30b-a3b-q4_K_M"
    [q25c]="qwen2.5-coder:14b-instruct-q4_K_M"
    [g4]="gemma4:31b-it-q4_K_M"
    [g4m]="gemma4:26b-a4b-it-q4_K_M"
    [e4b]="gemma4:e4b-it-q4_K_M"
  )
  local labels=(
    "q3   — qwen3 32B"
    "q3c  — qwen3-coder 30B A3B"
    "q25c — qwen2.5-coder 14B"
    "g4   — gemma4 31B"
    "g4m  — gemma4 26B A4B"
    "e4b  — gemma4 E4B"
  )
  local keys=(q3 q3c q25c g4 g4m e4b)

  if [[ -n "${models[$1]}" ]]; then
    ollama run "${models[$1]}"
  else
    echo "Pick a model:"
    for i in {1..${#labels[@]}}; do
      echo "  $i) ${labels[$i]}"
    done
    echo -n "? "
    read choice
    local key="${keys[$choice]}"
    [[ -n "$key" ]] && ollama run "${models[$key]}"
  fi
}

# ai <shortcode> to launch aider with a model, or just `ai` for a picker
function ai() {
  local -A models=(
    [q3c]="ollama/qwen3-coder:30b-a3b-q4_K_M"
    [q25c]="ollama/qwen2.5-coder:14b-instruct-q4_K_M"
    [q3]="ollama/qwen3:32b-q4_K_M"
    [g4]="ollama/gemma4:31b-it-q4_K_M"
    [g4m]="ollama/gemma4:26b-a4b-it-q4_K_M"
    [e4b]="ollama/gemma4:e4b-it-q4_K_M"
  )
  local labels=(
    "q3   — qwen3 32B"
    "q3c  — qwen3-coder 30B A3B"
    "q25c — qwen2.5-coder 14B"
    "g4   — gemma4 31B"
    "g4m  — gemma4 26B A4B"
    "e4b  — gemma4 E4B"
  )
  local keys=(q3 q3c q25c g4 g4m e4b)

  if [[ -n "${models[$1]}" ]]; then
    aider --model "${models[$1]}" "${@:2}"
  else
    echo "Pick a model:"
    for i in {1..${#labels[@]}}; do
      echo "  $i) ${labels[$i]}"
    done
    echo -n "? "
    read choice
    local key="${keys[$choice]}"
    [[ -n "$key" ]] && aider --model "${models[$key]}"
  fi
}

# Track cwd for foot and new window spawning
function osc7_cwd() {
    printf '\e]7;file://%s%s\a' "$HOST" "${PWD// /%20}"
    mkdir -p "$HOME/.local/share/foot"
    echo "$PWD" > "$HOME/.local/share/foot/cwd"
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd osc7_cwd
osc7_cwd

eval "$(starship init zsh)"
