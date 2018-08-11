# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Set term
# TERM=rxvt-unicode-256color

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode archlinux python systemd common-aliases)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.cargo/bin
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

# Run make in parallel threads
export MAKEFLAGS="-j`nproc`"

# Compile flags
export CFLAGS="-march=native -pipe -fstack-protector-strong"
export CXXFLAGS="${CFLAGS}"

# Setup racer variables for rust
which rustc &> /dev/null
if [ $? -eq 0 ]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
ALIAS_FILE="$HOME/.zsh_aliases"
if [[ -f $ALIAS_FILE ]]; then
    source $ALIAS_FILE
fi

# zsh prompt with git
local ret_status="%(?:%{$fg[green]%}:%{$fg[red]%})"
PROMPT='%{$fg[yellow]%}[%*]${ret_status}[%n@%m: %~]$(git_prompt_info)-> % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%})%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%})"

# alias ohmyzsh="mate ~/.oh-my-zsh"

# If in tty1, start X
if [[ -z "$DISPLAY" ]] && [[ $(tty) == /dev/tty1 ]]; then
    startx
fi

# Stupid oh-my-zsh aliases
unalias rm cp mv &> /dev/null || true

# Key binding for reverse history search
bindkey '^R' history-incremental-search-backward
