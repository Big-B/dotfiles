#! /bin/sh

# Set X settings for terminal and others
xrdb ~/.Xresources

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

# Get rid of beep
xset -b

# Set background
feh --bg-scale /home/mittmanb/syncthing/sync/desktop/blue_snake.jpg

# Setup auto locking
# Lock screen after 5 minutes using i3lock
/usr/bin/xautolock -detectsleep -time 5 -locker "/usr/bin/i3lock-fancy -p -t '' -- /usr/bin/scrot" &

# Turn computer off after 10 minutes
/usr/bin/xautolock -time 10 -locker "systemctl poweroff" &

# Start i3
exec i3 &> ~/.i3.log
