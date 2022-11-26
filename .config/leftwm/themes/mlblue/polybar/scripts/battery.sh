#!/bin/bash

ls -la /sys/class/power_supply/ | grep BAT | cut -f"11" -d" "
ls -la /sys/class/power_supply/ | grep ADP | cut -f"11" -d" "
