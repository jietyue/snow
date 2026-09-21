-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
     hl.exec_cmd("hyprctl dispatch focusmonitor DP-1")
     hl.exec_cmd("qs -c ~/snow/dotfiles/quickshell & hyprpaper -c ~/snow/dotfiles/hypr/hyprpaper.conf & hyprlock -c ~/snow/dotfiles/hypr/hyprlock.conf")
end)