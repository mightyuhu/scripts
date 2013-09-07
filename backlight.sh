#!/bin/bash
light=$(cat /sys/class/leds/samsung\:\:kbd_backlight/brightness);
max_light=$(cat /sys/class/leds/samsung\:\:kbd_backlight/max_brightness);

if [ "$1" == "inc" ]; then
  newlight=$((light + 1));
  if [ $newlight -gt $max_light ]; then
  newlight=8;
  fi
else
  newlight=$((light - 1));
  if [ $newlight -lt 0 ]; then
  newlight=0;
  fi
fi
echo $newlight > /sys/class/leds/samsung\:\:kbd_backlight/brightness
echo keyboard lightness is now : $newlight;
