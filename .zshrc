# Path to your oh-my-zsh installation.
ZSH=~/.oh-my-zsh/

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
plugins=(git vi-mode archlinux python systemd common-aliases autojump)

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
export CFLAGS="-march=native -pipe -fstack-protector-strong -O3"
export CXXFLAGS="${CFLAGS}"

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

# Stupid oh-my-zsh aliases
unalias rm cp mv fd &> /dev/null || true

# Key binding for reverse history search
bindkey '^R' history-incremental-search-backward

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    source "$BASE16_SHELL/profile_helper.sh"

# zsh-autosuggestions
ZSH_AUTO_SUG="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f $ZSH_AUTO_SUG ]]; then
    source $ZSH_AUTO_SUG
    bindkey '^ ' autosuggest-accept
fi

# zsh-histdb
ZSH_HIST_DB="$HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh"
if [[ -f $ZSH_HIST_DB ]]; then
    source $ZSH_HIST_DB
    autoload -Uz add-zsh-hook

    source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/histdb-interactive.zsh
    bindkey '^R' _histdb-isearch

    # Use the database for autosuggestions
    if [[ -f $ZSH_AUTO_SUG ]]; then
        _zsh_autosuggest_strategy_histdb_top_here() {
            local query="select commands.argv from
            history left join commands on history.command_id = commands.rowid
            left join places on history.place_id = places.rowid
            where places.dir LIKE '$(sql_escape $PWD)%'
            and commands.argv LIKE '$(sql_escape $1)%'
            group by commands.argv order by count(*) desc limit 1"
            suggestion=$(_histdb_query "$query")
        }

        ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
    fi
fi

# If in tty1, start X
if [[ -z "$DISPLAY" ]] && [[ $(tty) == /dev/tty1 ]]; then
    XKB_DEFAULT_LAYOUT=us exec sway &> ~/.sway.log
fi

# GPG struggles to gather password without this
export GPG_TTY=$(tty)
