#!/bin/sh

isEnabled=$(xinput list-props "ELAN1200:00 04F3:30BA Touchpad" | grep "Device Enabled"| awk '{print $4}')

if [ $isEnabled -eq 1 ]; then
    xinput disable "ELAN1200:00 04F3:30BA Touchpad"
else
    xinput enable "ELAN1200:00 04F3:30BA Touchpad"
fi
