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

# Get rid of beep
xset -b

# Set i3lock as locker utility with 10 minute limit
xautolock -time 10 -locker "/usr/bin/i3lock -c 000000" &

# Set background
feh --bg-scale /home/mittmanb/syncthing/sync/desktop/blue_snake.jpg

# Start i3
exec i3 &> ~/.i3.log
