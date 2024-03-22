# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist
shopt -s histverify

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Replaced in .bash_profile
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# .bash_profile
# The typical bashrc stuff that can be taken from computer to computer.
# If not Arch, source .bash_profile, otherwise it's already been sourced
if [ -d ~/Dropbox/bin ]; then
    export PATH=$PATH:~/Dropbox/bin
fi


if [ -d ~/.gem/ruby/2.1.0/bin ]; then
    export PATH=$PATH:~/.gem/ruby/2.1.0/bin
fi

if [ -d ~/.gem/ruby/2.0.0/bin ]; then
    export PATH=$PATH:~/.gem/ruby/2.0.0/bin
fi

if [ -d ~/bin ]; then
    export PATH=$PATH:~/bin
fi

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize

# If in tty1, start X
if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]; then
    startx
fi



# If it is an interactive shell, then check if this is the only
# terminal, then print welcome message
#if [ -n "$PS1" ]; then
#    USERNAME=$(whoami)
#    LOGGED=$(w | grep -v "gnome" | grep -c $USERNAME)
#    if [ $LOGGED -le 1 ]; then
#        if [ $(date +%H) -lt 12 ]; then
#            echo -n "Good morning"
#        elif [ $(date +%H) -lt 19 ]; then
#            echo -n "Good afternoon"
#        else
#            echo -n "Good evening"
#        fi
#        echo ", sir. Welcome back."
#    fi
#fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Git completions script
if [ -f ~/Dropbox/bin/git-completion.bash ]; then
    . ~/Dropbox/bin/git-completion.bash
fi

# Git PS1 stuff
if [ -f ~/Dropbox/bin/git-prompt.sh ]; then
    . ~/Dropbox/bin/git-prompt.sh
fi


# View man pages in vim format
export MANPAGER="/bin/sh -c \"unset MANPAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

export GPGKEY=B7B34D4D
export GEM_HOME=~/.gem/ruby/2.0.0
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export CHEATCOLORS=true

# Prompt command, changes to red on bad return
# Shortens path if too long
if [ $SHLVL -gt 1 ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT_COMMAND='PS1="\[\033[0;33m\][\t]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo \"\\W\"; else echo \"\\w\"; fi\`]->\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'
    if [ -f ~/Dropbox/bin/git-prompt.sh ]; then
        . ~/Dropbox/bin/git-prompt.sh
        PROMPT_COMMAND='PS1="\[\033[0;33m\][\t]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u@\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo \"\\W\"; else echo \"\\w\"; fi\`]$(__git_ps1 "(%s)")->\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
