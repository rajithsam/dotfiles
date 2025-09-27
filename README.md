# Hyprland Vanilla Arch Setup

This repository provides a script and configuration files to quickly set up a beautiful Hyprland desktop environment on a fresh vanilla Arch Linux installation, inspired by the omarchy rice.

## Features
- Hyprland Wayland compositor
- Gruvbox theme and icons
- Waybar, Dunst, Kitty, Alacritty, VLC, Rofi, Thunar, Nautilus, and more
- Hyprlock lockscreen with omarchy-style visuals
- Omarchy-style screensaver using swayidle
- Gruvbox wallpapers and lockscreen images
- Fonts: JetBrains Mono, FiraCode, Nerd Fonts, Yaru, Cascadia Mono, IA Writer
- NVIDIA GPU support
- Modern CLI tools: bat, btop, dust, eza, fd, fzf, ripgrep, tldr, zoxide
- Git utilities: github-cli, lazygit
- System info: fastfetch
- Hyprland utilities: hypridle, hyprpicker, hyprshot, hyprsunset
- Media/viewer/editor: imv, mpv, pinta, obs-studio, kdenlive, xournalpp
- Notifications: mako
- Shell prompt: starship
- Note-taking: typora, obsidian
- Communication: signal-desktop, spotify, discord, zoom
- Firewall: ufw, ufw-docker
- Dev tools: tree-sitter-cli, luarocks, python-poetry-core
- Power management: power-profiles-daemon
- Boot splash: plymouth
- Printing: system-config-printer, cups, cups-pdf
- Input method: fcitx5, fcitx5-gtk, fcitx5-qt
- Qt theming: kvantum-qt5
- Extra icons/fonts: yaru-icon-theme, woff2-font-awesome
- App launcher: walker-bin
- Wayland clipboard/screenshot: wl-clip-persist, wl-screenrec, hyprshot
- Data tools: xmlstarlet, jq
- Dev env manager: mise
- File transfer: localsend
- DB libs: mariadb-libs, postgresql-libs
- Network discovery: nss-mdns, avahi
- Bluetooth: blueberry
- Brightness control: brightnessctl
- Screenshot annotation: satty
- File preview: sushi
- Wayland session manager: uwsm

## Step-by-Step Installation

### 1. Install Arch Linux
- Complete a base Arch installation and create a user account.

### 2. Clone this repository
```sh
git clone https://github.com/rajithsam/dotfiles.git ~/dotfiles
cd ~/dotfiles/hyprland
```

### 3. Run the setup script
```sh
sh setup-hyprland.sh
```
- The script will install all required packages and dependencies (including all extra features above).
- It will also download Gruvbox wallpapers and lockscreen images.
- Hyprlock configuration will be placed in `.config/hypr/hyprlock.conf`.
- Swayidle will be installed for screensaver functionality.

### 4. Apply Gruvbox theme and icons
- Run `lxappearance` and select 'Gruvbox' (from AUR) for GTK theme and icons, or use 'Papirus' as fallback.

### 5. Set your wallpaper
- Use `/home/<youruser>/Documents/hyprland/Pictures/wallpaper-gruvbox.png` as your desktop wallpaper.

### 6. Configure Hyprlock
- The lockscreen uses `/home/<youruser>/Documents/hyprland/Pictures/lockscreen.png`.
- You can further customize `.config/hypr/hyprlock.conf`.

### 7. Bind lockscreen key
- Add to your Hyprland config:
  ```
  bind = $mod+L, exec, hyprlock
  ```

### 8. Enable omarchy-style screensaver
- Add to your Hyprland config (`~/.config/hypr/hyprland.conf`):
  ```
  exec = swayidle -w timeout 300 'hyprlock' resume 'killall hyprlock'
  ```
- This will automatically lock the screen after 5 minutes of inactivity.

### 9. Additional notes
- For AUR packages, the script installs `yay` and `paru` if not present.
- To install Google Chrome and Microsoft VS Code, run:
  ```
  yay -S google-chrome visual-studio-code-bin
  ```
- Many extra features and utilities are included for a modern, productive desktop experience.
- NVIDIA drivers are installed and enabled for GeForce GTX 1650 Ti Mobile.
- Fonts are installed and ready to use in your terminal and editor.
- All configs are placed in `.config/`.

## Screenshots
- See the `Pictures/` directory for sample wallpapers and lockscreen images.

## Credits
- Inspired by [omarchy](https://github.com/basecamp/omarchy)

---
Enjoy your new Hyprland desktop!
