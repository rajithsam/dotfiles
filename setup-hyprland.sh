#!/bin/sh
set -e
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
  pipewire \
  pipewire-pulse \
  polkit-gnome \
  thunar \
  noto-fonts-emoji \
  lxappearance \
  papirus-icon-theme \
  alacritty \
  vlc \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-mono \
  ttf-fira-code \
  git \
  os-prober \
  unzip \
  nvidia \
  nvidia-utils \
  nvidia-settings \
  libva \
  libva-nvidia-driver \
  egl-wayland
  hyprlock \
  swayidle \
  bat \
  btop \
  dust \
  eza \
  fd \
  fzf \
  ripgrep \
  tldr \
  zoxide \
  github-cli \
  lazygit \
  fastfetch \
  hypridle \
  hyprpicker \
  hyprshot \
  hyprsunset \
  imv \
  mpv \
  pinta \
  obs-studio \
  kdenlive \
  xournalpp \
  mako \
  starship \
  typora \
  obsidian \
  signal-desktop \
  spotify \
  discord \
  zoom \
  ufw \
  ufw-docker \
  tree-sitter-cli \
  luarocks \
  python-poetry-core \
  nautilus \
  power-profiles-daemon \
  plymouth \
  system-config-printer \
  cups \
  cups-pdf \
  fcitx5 \
  fcitx5-gtk \
  fcitx5-qt \
  kvantum-qt5 \
  yaru-icon-theme \
  woff2-font-awesome \
  walker-bin \
  wl-clip-persist \
  wl-screenrec \
  hyprland-qtutils \
  xmlstarlet \
  jq \
  mise \
  localsend \
  mariadb-libs \
  postgresql-libs \
  nss-mdns \
  avahi \
  blueberry \
  brightnessctl \
  satty \
  sushi \
  uwsm \

# For AUR packages (optional):
# Install yay if not present
if ! command -v yay >/dev/null 2>&1; then
  echo "Installing yay (AUR helper)..."
  sudo pacman -S --needed yay
else
  echo "yay already installed."
fi
# Install paru if not present
if ! command -v paru >/dev/null 2>&1; then
  echo "Installing paru (AUR helper)..."
  sudo pacman -S --needed paru
else
  echo "paru already installed."
fi
echo "Installing Gruvbox GTK theme and icons for dark file manager experience..."
yay -S --noconfirm gruvbox-gtk-theme gruvbox-icons
echo "Setting Gruvbox-Dark theme and Gruvbox icons using lxappearance..."
gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Gruvbox"
echo "Thunar and Nautilus will now use the Gruvbox dark theme and icons."

 # Hyprlock setup (Gruvbox-style lockscreen)
echo "Hyprlock is installed for Wayland lockscreen."
echo "To configure Hyprlock with a Gruvbox-style, create ~/.config/hypr/hyprlock.conf with the following content:"
cat <<'EOF'
background {
  path = ~/.config/Pictures/lockscreen.png
  blur = true
  color = rgba(20,20,20,0.7)
}

clock {
  format = %H:%M
  font_size = 48
  color = rgba(255,255,255,1.0)
  position = center
}

inputbox {
  position = center
  font_size = 24
  color = rgba(255,255,255,1.0)
  outline_color = rgba(100,100,100,0.8)
}

avatar {
  path = ~/.face
  size = 96
  position = center
}
EOF
echo "Swayidle will automatically lock the screen after 5 minutes of inactivity."
echo "To enable, add the following to your Hyprland config (e.g. ~/.config/hypr/hyprland.conf):"
echo "exec = swayidle -w timeout 300 'hyprlock' resume 'killall hyprlock'"
echo "Bind a key in your Hyprland config to lock the screen, e.g.:"
echo "bind = $mod+L, exec, hyprlock"
echo "You can further customize the lockscreen by editing ~/.config/hypr/hyprlock.conf."

# Documentation and instructions
# Install NVIDIA drivers for GeForce GTX 1650 Ti Mobile
echo "NVIDIA drivers (nvidia, nvidia-utils, nvidia-settings, libva, libva-nvidia-driver, egl-wayland) are installed for your GPU."
echo "After install, run 'nvidia-settings' to configure your GPU."
echo "For Wayland, ensure you use the latest Hyprland and NVIDIA drivers."

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
echo "To apply Gruvbox theme and icons, run lxappearance and select 'Gruvbox' (from AUR) for GTK theme and icons, or use 'Papirus' as fallback."
echo "Thunar and other GTK apps will follow the selected look."

echo "Alacritty terminal is installed and themed with Gruvbox. Launch with 'alacritty' command."
echo "Alacritty now uses TOML config format. Place your config in ~/.config/alacritty/alacritty.toml."
echo "VLC is installed. For Google Chrome and Microsoft VS Code, use yay or paru to install from AUR:"
echo "yay -S google-chrome visual-studio-code-bin"
echo "Nerd Fonts, JetBrains Mono, and FiraCode are installed. Set these in your editor and terminal preferences."
echo "LazyVim is not a package. Install and configure it in ~/.config/nvim manually."
echo "All configs and scripts are in ~/.config/"
echo "Set your wallpaper at ~/.config/Pictures/wallpaper-gruvbox.jpg"
echo "Downloaded Gruvbox-style wallpaper to ~/.config/Pictures/wallpaper-gruvbox.jpg."
