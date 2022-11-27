#!/bin/bash

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
new_brightness=$(($brightness - 200))

if [[ $new_brightness -gt 0 ]]; then
  echo $new_brightness > /sys/class/backlight/intel_backlight/brightness 
fi
