xrdb -merge ~/.Xresources

# HiDPI cursor size
export XCURSOR_SIZE=36

# Mouse settings - 1:1 raw input (control speed via mouse DPI)
xinput set-prop "pointer:2.4G Wireless Device" "libinput Accel Profile Enabled" 0 1 2>/dev/null
xinput set-prop "pointer:2.4G Wireless Device" "libinput Accel Speed" 0 2>/dev/null
xinput set-prop "pointer:2.4G Wireless Device" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 1 2>/dev/null

# Touchpad sensitivity
xinput set-prop "Apple SPI Touchpad" "libinput Accel Speed" 1.0 2>/dev/null
xinput set-prop "Apple SPI Touchpad" "libinput Scrolling Pixel Distance" 50 2>/dev/null

# Start dwm status bar
~/.local/bin/dwm-status &

# Wallpaper
~/.fehbg &

exec dwm
