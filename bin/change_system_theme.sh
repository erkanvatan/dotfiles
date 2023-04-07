#!/usr/bin/env bash
# Switch between system wide dark and light mode with each execution

dark_theme='Dracula'
light_theme='Mint-Y'

color_value="$(cat /tmp/system_theme_color 2>/dev/null)"

# if 
if [[ "$color_value" = "light" ]]; then
    theme=$dark_theme
    echo "dark" > /tmp/system_theme_color
else
    theme=$light_theme 
    echo "light" > /tmp/system_theme_color
fi


gsettings set org.cinnamon.desktop.interface icon-theme $theme
gsettings set org.cinnamon.desktop.interface gtk-theme $theme
gsettings set org.cinnamon.desktop.wm.preferences theme $theme
gsettings set org.mate.interface icon-theme  $theme
gsettings set org.mate.interface gtk-theme  $theme
gsettings set org.cinnamon.theme name  $theme

gsettings set org.gnome.desktop.interface icon-theme $theme
gsettings set org.gnome.desktop.interface gtk-theme $theme
