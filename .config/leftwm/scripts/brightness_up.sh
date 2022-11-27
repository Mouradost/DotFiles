#!/bin/bash

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
new_brightness=$(($brightness + 200))

if [[ $new_brightness -lt $max_brightness ]]; then
  echo $new_brightness > /sys/class/backlight/intel_backlight/brightness 
fi
