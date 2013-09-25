#! /bin/sh

# Wait for program
wait_for () {
    echo wait
    n=0
    while true
    do
    if $1; then
        echo f
        break
    else
        echo mmm
        # 10 seconds timeout
        if [ $n -eq 10000 ]; then
        xmessage "Error on: $1"
        break
        else
        n=`expr $n + 1`
        sleep .001
        fi
    fi
    done
    sleep 1
}

lxterminal &
wait_for "xdotool search --onlyvisible --pid $! --name lxterminal"
i3-msg split h
lxterminal &
wait_for "xdotool search --onlyvisible --pid $! --name lxterminal"
i3-msg resize grow width 20 px or 20 ppt
i3-msg split v
lxterminal &
wait_for "xdotool search --onlyvisible --pid $! --name lxterminal"
i3-msg focus parent
i3-msg split h
lxterminal &
wait_for "xdotool search --onlyvisible --pid $! --name lxterminal"
i3-msg 'workspace 4-Spotify'
spotify&
