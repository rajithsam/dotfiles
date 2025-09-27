#!/bin/sh
# Minimal Hyprland rice setup for Arch Linux (Gruvbox, interactive Waybar)

sudo pacman -S --needed \
  hyprland \
  waybar \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal \
  wl-clipboard \
  swaylock \
  swaybg \
  rofi-wayland \
  dunst \
  kitty \
  grim \
  slurp \
  playerctl \
  pavucontrol \
  networkmanager \
  network-manager-applet \
  ttf-jetbrains-mono \
  ttf-font-awesome \
  gnome-calendar \
  nmcli \
  pipewire \
  pipewire-pulse \
  polkit-gnome \
  thunar \
  noto-fonts-emoji \
  lxappearance \
  gruvbox-gtk-theme \
  gruvbox-icons \
  alacritty \
  code \
  google-chrome \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-mono \
  ttf-firacode \
  lazyvim \
  git \
  nvidia \
  nvidia-utils \
  nvidia-settings \
  libva \
  libva-nvidia-driver \
  egl-wayland \
  chatgpt-electron
# Install ChatGPT Electron app for AI chat
echo "ChatGPT Electron app (chatgpt-electron) is installed. Launch with 'chatgpt-electron' command."
# Install NVIDIA drivers for GeForce GTX 1650 Ti Mobile
echo "NVIDIA drivers (nvidia, nvidia-utils, nvidia-settings, libva, libva-nvidia-driver, egl-wayland) are installed for your GPU."
echo "After install, run 'nvidia-settings' to configure your GPU."
echo "For Wayland, ensure you use the latest Hyprland and NVIDIA drivers."
# LazyVim is installed. Configure ~/.config/nvim for your workflow.
echo "LazyVim is installed. Configure ~/.config/nvim for your workflow."

# Install nvm (Node Version Manager) for managing Node.js versions
if ! command -v nvm >/dev/null 2>&1; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  echo "nvm installed. Restart your shell or source ~/.bashrc/.zshrc to use it."
else
  echo "nvm already installed."
fi

systemctl --user enable --now pipewire pipewire-pulse
systemctl enable NetworkManager


# Set Gruvbox theme and icons for Thunar and GTK apps
echo "To apply Gruvbox theme and icons, run lxappearance and select 'Gruvbox' for both GTK theme and icons."
echo "Thunar and other GTK apps will follow the Gruvbox look."


# Alacritty terminal is installed and themed with Gruvbox in ~/.config/alacritty/
echo "Alacritty is installed and themed with Gruvbox. Launch with 'alacritty' command."

# VSCode and Google Chrome are installed for web development.
echo "VSCode (code) and Google Chrome (google-chrome) are installed."

# Nerd Fonts, JetBrains Mono, and FiraCode are installed for best dev experience.
echo "Nerd Fonts, JetBrains Mono, and FiraCode are installed. Set these in your editor and terminal preferences."

# LazyVim is installed. Configure ~/.config/nvim for your workflow.
echo "LazyVim is installed. Configure ~/.config/nvim for your workflow."

# Reminder for user
cat << EOF
All configs and scripts are in ~/.config/
Set your wallpaper at ~/Pictures/wallpapers/gruvbox.png
EOF

# Automatically set up config files
mkdir -p ~/.config/hypr ~/.config/waybar/scripts ~/.config/dunst ~/.config/rofi ~/.config/kitty ~/.config/alacritty

# Hyprland config
touch ~/.config/hypr/hyprland.conf && cat > ~/.config/hypr/hyprland.conf << 'EOL'
monitor=,preferred,auto,1
input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = yes
    }
}
general {
    gaps_in = 6
    gaps_out = 12
    border_size = 2
    col.active_border = rgba(d79921ff) rgba(b16286ff) 45deg
    col.inactive_border = rgba(504945ff) rgba(282828ff) 45deg
    layout = dwindle
}
decoration {
    rounding = 8
    blur = yes
    blur_size = 6
    drop_shadow = yes
    shadow_range = 20
    shadow_render_power = 3
    col.shadow = rgba(282828ee)
}
animations {
    enabled = yes
    bezier = ease,0.4,0.02,0.21,1
    animation = windows,1,3,ease
    animation = fade,1,3,ease
    animation = border,1,3,ease
}
bind = $mod, RETURN, exec, kitty
bind = $mod, Q, killactive,
bind = $mod, M, exec, rofi -show drun
bind = $mod, F, fullscreen,
bind = $mod, E, exec, thunar
bind = $mod, V, togglefloating,
bind = $mod, P, exec, pavucontrol
bind = $mod, S, exec, swaylock
bind = $mod, Print, exec, grim -g "$(slurp)" - | wl-copy
exec-once = waybar
exec-once = dunst
exec-once = nm-applet
exec-once = swaybg -i ~/Pictures/wallpapers/gruvbox.png
EOL

# Add transparency to Hyprland config
touch ~/.config/hypr/hyprland.conf && sed -i '/^decoration {/a\    active_opacity = 0.92\n    inactive_opacity = 0.85' ~/.config/hypr/hyprland.conf

# Waybar config
touch ~/.config/waybar/config.jsonc && cat > ~/.config/waybar/config.jsonc << 'EOL'
{
  "layer": "top",
  "position": "top",
  "modules-left": ["hyprland/workspaces", "hyprland/window"],
  "modules-center": [
    {
      "name": "clock",
      "format": "{:%a %d %b %H:%M}",
      "on-click": "gnome-calendar"
    }
  ],
  "modules-right": [
    {
      "name": "custom/network",
      "interval": 5,
      "exec": "~/.config/waybar/scripts/network.sh",
      "on-click": "nm-applet"
    },
    {
      "name": "custom/volume",
      "interval": 2,
      "exec": "~/.config/waybar/scripts/volume.sh",
      "on-click": "~/.config/waybar/scripts/volume.sh open",
      "on-click-right": "~/.config/waybar/scripts/volume.sh toggle"
    },
    {
      "name": "custom/battery",
      "interval": 30,
      "exec": "~/.config/waybar/scripts/battery.sh",
      "on-click": "gnome-control-center power"
    },
    {
      "name": "custom/clipboard",
      "interval": 2,
      "exec": "~/.config/waybar/scripts/clipboard.sh"
    },
    {
      "name": "custom/updates",
      "interval": 1800,
      "exec": "~/.config/waybar/scripts/updates.sh",
      "tooltip": false,
      "on-click": "kitty -e sudo pacman -Syu"
    },
    "tray"
  ]
}
EOL

touch ~/.config/waybar/style.css && cat > ~/.config/waybar/style.css << 'EOL'
* {
    font-family: "JetBrains Mono", "FiraCode Nerd Font", "FiraCode", "Nerd Font", "FontAwesome", sans-serif;
    font-size: 14px;
}
window {
    background: #282828;
    color: #ebdbb2;
}
#workspaces button.active {
    background: #d79921;
    color: #282828;
}
#workspaces button {
    background: #504945;
    color: #ebdbb2;
}
#clock, #custom-network, #custom-volume, #custom-battery, #custom-clipboard, #custom-updates, #tray {
    background: #282828;
    color: #ebdbb2;
    border-radius: 6px;
    padding: 0 10px;
    margin: 0 2px;
    transition: background 0.2s;
}
#custom-network:hover, #custom-volume:hover, #custom-battery:hover, #custom-clipboard:hover, #custom-updates:hover {
    background: #d79921;
    color: #282828;
    cursor: pointer;
}
EOL

# Add transparency to Waybar style
sed -i 's/background: #282828;/background: rgba(40,40,40,0.92);/g' ~/.config/waybar/style.css

# Waybar scripts
cat > ~/.config/waybar/scripts/volume.sh << 'EOL'
#!/bin/sh
if [ "$1" = "toggle" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [ "$1" = "open" ]; then
    pavucontrol
else
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
    MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'yes|no')
    if [ "$MUTE" = "yes" ]; then
        echo " Muted"
    else
        echo " $VOL"
    fi
fi
EOL
chmod +x ~/.config/waybar/scripts/volume.sh

cat > ~/.config/waybar/scripts/network.sh << 'EOL'
#!/bin/sh
STATUS=$(nmcli -t -f WIFI g)
if [ "$STATUS" = "enabled" ]; then
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -n "$SSID" ]; then
        echo " $SSID"
    else
        echo "睊 Disconnected"
    fi
else
    echo "睊 Disabled"
fi
EOL
chmod +x ~/.config/waybar/scripts/network.sh

cat > ~/.config/waybar/scripts/battery.sh << 'EOL'
#!/bin/sh
BAT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)
if [ "$STATUS" = "Charging" ]; then
    ICON=""
else
    ICON=""
fi
if [ -n "$BAT" ]; then
    echo "$ICON $BAT%"
else
    echo " N/A"
fi
EOL
chmod +x ~/.config/waybar/scripts/battery.sh

cat > ~/.config/waybar/scripts/clipboard.sh << 'EOL'
#!/bin/sh
CLIP=$(wl-paste --no-newline)
if [ -n "$CLIP" ]; then
    echo ""
else
    echo "󰅯"
fi
EOL
chmod +x ~/.config/waybar/scripts/clipboard.sh

cat > ~/.config/waybar/scripts/updates.sh << 'EOL'
#!/bin/sh
UPDATES=$(checkupdates 2>/dev/null | wc -l)
if [ "$UPDATES" -gt 0 ]; then
    echo " $UPDATES"
else
    echo ""
fi
EOL
chmod +x ~/.config/waybar/scripts/updates.sh

# Dunst config
touch ~/.config/dunst/dunstrc && cat > ~/.config/dunst/dunstrc << 'EOL'
[global]
    font = JetBrains Mono 10
    frame_color = "#d79921"
    separator_color = "#b16286"
    background = "#282828"
    foreground = "#ebdbb2"
    width = 300
    height = 80
    transparency = 10
    corner_radius = 8
EOL

# Add transparency to Dunst config
sed -i 's/transparency = 10/transparency = 20/' ~/.config/dunst/dunstrc

# Rofi config
touch ~/.config/rofi/config.rasi && cat > ~/.config/rofi/config.rasi << 'EOL'
* {
    background: #282828;
    foreground: #ebdbb2;
    border-color: #d79921;
    selected: #b16286;
    font: "JetBrains Mono 12";
}
EOL

# Add transparency to Rofi config
sed -i '1s/^/* {\n    transparency: "real";\n    opacity: 92;\n}\n/' ~/.config/rofi/config.rasi

# Kitty config
touch ~/.config/kitty/kitty.conf && cat > ~/.config/kitty/kitty.conf << 'EOL'
font_family      JetBrains Mono
font_size        12.0
include theme.conf
background       #282828
foreground       #ebdbb2
selection_background #b16286
selection_foreground #282828
url_color        #d79921
cursor           #d79921
active_tab_background #d79921
active_tab_foreground #282828
inactive_tab_background #504945
inactive_tab_foreground #ebdbb2
EOL

touch ~/.config/kitty/theme.conf && cat > ~/.config/kitty/theme.conf << 'EOL'
background #282828
foreground #ebdbb2
color0 #282828
color1 #cc241d
color2 #98971a
color3 #d79921
color4 #458588
color5 #b16286
color6 #689d6a
color7 #a89984
color8 #928374
color9 #fb4934
color10 #b8bb26
color11 #fabd2f
color12 #83a598
color13 #d3869b
color14 #8ec07c
color15 #ebdbb2
EOL

# Add transparency to Kitty config
sed -i 's/^background       #282828/background       rgba(40,40,40,0.92)/' ~/.config/kitty/kitty.conf

# Alacritty config
touch ~/.config/alacritty/alacritty.yml && cat > ~/.config/alacritty/alacritty.yml << 'EOL'
import:
  - ~/.config/alacritty/gruvbox.yml
font:
  normal:
    family: JetBrains Mono
    style: Regular
  size: 12.0
window:
  opacity: 0.95
cursor:
  style: Beam
  unfocused_hollow: true
selection:
  save_to_clipboard: true
EOL

touch ~/.config/alacritty/gruvbox.yml && cat > ~/.config/alacritty/gruvbox.yml << 'EOL'
colors:
  primary:
    background: '#282828'
    foreground: '#ebdbb2'
  normal:
    black:   '#282828'
    red:     '#cc241d'
    green:   '#98971a'
    yellow:  '#d79921'
    blue:    '#458588'
    magenta: '#b16286'
    cyan:    '#689d6a'
    white:   '#a89984'
  bright:
    black:   '#928374'
    red:     '#fb4934'
    green:   '#b8bb26'
    yellow:  '#fabd2f'
    blue:    '#83a598'
    magenta: '#d3869b'
    cyan:    '#8ec07c'
    white:   '#ebdbb2'
EOL

# Add transparency to Alacritty config
sed -i 's/^window:/window:\n  opacity: 0.92/' ~/.config/alacritty/alacritty.yml

echo "All configs and scripts are now placed in ~/.config/ automatically."
echo "Set your wallpaper at ~/Pictures/wallpapers/gruvbox.png"
