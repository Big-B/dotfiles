if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Swap caps lock and escape keys
# Doesn't work right when at shell level 1
if [ $SHLVL -gt 1 ]; then
    if [ -f ~/.speedmap ]; then
        xmodmap ~/.speedmap
    fi
fi
