#!/usr/bin/env bash
cliphist list \
  | rofi -dmenu \
         -display-columns 2 \
         -p "󰅇  Clipboard" \
         -theme ~/.config/rofi/launcher.rasi \
  | cliphist decode | wl-copy
