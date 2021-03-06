# (R) = requires argument
# No correct
alias git="nocorrect git"
alias cargo="nocorrect cargo"

# Update mirrorlist sorted by rate
alias reflector="sudo reflector --verbose --sort rate --threads `nproc` --save /etc/pacman.d/mirrorlist"

# ssh to lectura
alias lectura="ssh mittmanb@lectura.cs.arizona.edu"

# List commands
alias ls="ls -hF --color=auto"
alias ll="ls -l"
alias lr="ls -R" # Recursive list
alias la="ll -a"
alias lx="ll -BX" # Sort by extensions
alias lz="ll -rS" # Sort by size
alias lt="ll -rt" # Sort by date
alias l="ls -CF"
alias lm="la | less"

# Filesystem/process commands
alias df='df -h' # Human readable
alias du='du -c -h' # Human readable, print total
alias mkdir='mkdir -p -v' # Makes parent directories, verbose for each directory created
alias da='date "+%A, %B %d, %Y [%T]"' # Prints out nicely formattted date
alias dul='du --max-depth=1' # Estimated disk usage of depth=1
alias hist='history | grep' # (R) Search history
alias openports='ss --all --numeric --processess --ipv4 --ipv6' # Lists open ports and processess using them
alias psall='ps -eLo pid,tid,psr,rtprio,policy,pri,state,%cpu,cputime,user,stat,wchan:20,comm:32'
alias psi='ps -eLo pid,tid,psr,rtprio,policy,pri,stat,%cpu,cputime,user,stat,wchan:20,comm:32 --sort %cpu'
alias pgg='ps -Af | grep' # (R) Search running processess

# Grep commands
alias egrep='egrep --exclude=cscope.out --exclude=tags --color=auto'
alias fgrep='fgrep --exclude=cscope.out --exclude=tags --color=auto'
alias grep='grep --exclude=cscope.out --exclude=tags --color=auto'
alias hgrep='history | grep -i '

alias shutdown='sudo shutdown now'
alias c="clear"
alias depth="find . -printf '%d\n' | sort -n | tail -1"
alias :wq="echo \"You're not in vim, you fucking moron.\""
alias :q="echo \"You're not in vim, you fucking moron.\""
alias :w="echo \"You're not in vim, you fucking moron.\""
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias bc="bc -l"

alias steam-wine='WINEDEBUG=-all wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'

# Look for neovim
if [ -x "$(command -v nvim)" ]; then
    alias vim='nvim'
fi

# Use info with vi bindings
alias info="info --vi-keys"

set -o vi
