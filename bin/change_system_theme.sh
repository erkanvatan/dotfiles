#!/usr/bin/env bash
# Switch between system wide dark and light mode with each execution

dark_theme='Adapta-Nokto'
dark_theme_icon='ePapirus-Dark'
light_theme='Adapta'
light_theme_icon='ePapirus'

color_value="$(cat /tmp/system_theme_color 2>/dev/null)"

# if 
if [[ "$color_value" = "light" ]]; then
    theme=$dark_theme
    icon_theme=$dark_theme_icon
    echo "dark" > /tmp/system_theme_color
else
    theme=$light_theme 
    icon_theme=$light_theme_icon
    echo "light" > /tmp/system_theme_color
fi


gsettings set org.cinnamon.desktop.interface icon-theme $icon_theme
gsettings set org.cinnamon.desktop.interface gtk-theme $theme
gsettings set org.cinnamon.desktop.wm.preferences theme $theme
gsettings set org.mate.interface icon-theme  $icon_theme
gsettings set org.mate.interface gtk-theme  $theme
gsettings set org.cinnamon.theme name  $theme

gsettings set org.gnome.desktop.interface icon-theme $icon_theme
gsettings set org.gnome.desktop.interface gtk-theme $theme
