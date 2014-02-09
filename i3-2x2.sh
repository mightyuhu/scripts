#!/bin/bash
i3-msg 'focus parent; layout splith'
~/Scripts/i3-exec-wait.pl lxterminal
~/Scripts/i3-exec-wait.pl lxterminal
i3-msg 'split v'
~/Scripts/i3-exec-wait.pl lxterminal
i3-msg 'focus left; split v'
~/Scripts/i3-exec-wait.pl lxterminal
i3-msg 'focus up'
