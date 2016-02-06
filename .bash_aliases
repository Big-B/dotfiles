# (R) = requires argument

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
alias top='"xterm" -fn 6x13 -geometry 100x50 -bg black -fg green -j -ls -sb -sf -sl 500 -vb -T `hostname` -e top &'
alias psall='ps -eLo pid,tid,psr,rtprio,policy,pri,state,%cpu,cputime,user,stat,wchan:20,comm:32'
alias psi='ps -eLo pid,tid,psr,rtprio,policy,pri,stat,%cpu,cputime,user,stat,wchan:20,comm:32 --sort %cpu'
alias pgg='ps -Af | grep' # (R) Search running processess

# Grep commands
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias hgrep='history | grep -i '

alias shutdown='sudo shutdown now'
alias c="clear"
alias xterm='xterm -bg black -fg green &'
alias depth="find . -printf '%d\n' | sort -n | tail -1"
alias :wq="echo \"You're not in vim, you fucking moron.\""
alias :q="echo \"You're not in vim, you fucking moron.\""
alias :w="echo \"You're not in vim, you fucking moron.\""
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias bc="bc -l"

# Router Stuff
alias router="ssh root@192.168.1.1"
alias mount_router="sshfs root@192.168.1.1:/opt/VIDEO /mnt/router -C -o umask=777"

set -o vi
