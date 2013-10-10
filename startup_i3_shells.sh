#!/bin/bash
i3-msg 'focus parent; layout splith'
~/Scripts/i3-exec-wait/i3-exec-wait lxterminal
~/Scripts/i3-exec-wait/i3-exec-wait lxterminal
i3-msg 'resize grow width 20 px or 20 ppt'
i3-msg 'split v'
~/Scripts/i3-exec-wait/i3-exec-wait lxterminal
i3-msg 'focus left; split v'
~/Scripts/i3-exec-wait/i3-exec-wait lxterminal
i3-msg 'focus up'
i3-msg 'focus parent'
i3-msg 'focus right'
i3-msg 'split h'
~/Scripts/i3-exec-wait/i3-exec-wait lxterminal
exec i3-msg 'workspace 4-Spotify;'
~/Scripts/i3-exec-wait/i3-exec-wait spotify
