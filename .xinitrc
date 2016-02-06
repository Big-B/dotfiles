#! /bin/sh

# Set X settings for terminal and others
xrdb ~/.Xresources

# Start running conky
#if [ `ps -e | grep -c conky` = 0 ]; then
#    conky -x 0 -y -10 -d &> /dev/null
#fi

# Run clock, update every second
while true
    do
        xsetroot -name  "$(date +"%a %b %d %r")"
        sleep 1s
done &

# Set speedmap
if [ -f ~/.speedmap ]; then
    xmodmap ~/.speedmap
fi

# Turn on numlock
numlockx &

# Start Dropbox
dropboxd &
sh /home/mittmanb/.dpbx &

exec awesome
