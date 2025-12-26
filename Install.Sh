#!/usr/bin/env bash
set -e

echo "🔥 Rose Pine XFCE | ALL IN ONE INSTALLER"

REPO_URL="https://github.com/MikeTeok/LinuxMint-XFCE-RosePine"
DIR="$HOME/.rosepine-xfce"

### ---------------- UPDATE ----------------
sudo pacman -Syu --noconfirm

### ---------------- BASE PACKAGES ----------------
sudo pacman -S --needed --noconfirm \
  git curl wget \
  xfce4-goodies xfce4-whiskermenu-plugin \
  picom fish plank firefox \
  neovim alacritty neofetch \
  gtk-engine-murrine papirus-icon-theme

### ---------------- YAY ----------------
if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

### ---------------- AUR ----------------
yay -S --needed --noconfirm \
  eww \
  oh-my-posh-bin \
  rose-pine-gtk-theme

### ---------------- CLONE RICE ----------------
rm -rf "$DIR"
git clone "$REPO_URL" "$DIR"

### ---------------- COPY CONFIGS ----------------
mkdir -p ~/.config ~/.local/share/themes ~/.icons
cp -r "$DIR/.config/"* ~/.config/
cp -r "$DIR/.themes/"* ~/.local/share/themes/ || true
cp -r "$DIR/.icons/"* ~/.icons/ || true
cp -r "$DIR/.local/"* ~/.local/

### ---------------- FISH ----------------
if ! grep -q "$(which fish)" /etc/shells; then
  echo "$(which fish)" | sudo tee -a /etc/shells
fi
sudo chsh -s "$(which fish)" "$USER"
echo "neofetch" >> ~/.config/fish/config.fish

### ---------------- PICOM AUTOSTART ----------------
mkdir -p ~/.config/autostart
cat <<EOF > ~/.config/autostart/picom.desktop
[Desktop Entry]
Type=Application
Exec=picom --config ~/.config/picom/picom.conf
Name=Picom
EOF

### ---------------- PLANK AUTOSTART ----------------
cat <<EOF > ~/.config/autostart/plank.desktop
[Desktop Entry]
Type=Application
Exec=plank
Name=Plank
EOF

### ---------------- XFCE PANEL + WHISKER ----------------
xfconf-query -c xfce4-panel -p /panels -rR || true

xfconf-query -c xfce4-panel -p /panels -t int -s 1 --create
xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=6;x=0;y=0"
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 36
xfconf-query -c xfce4-panel -p /panels/panel-1/length -s 100
xfconf-query -c xfce4-panel -p /panels/panel-1/length-adjust -s true

xfconf-query -c xfce4-panel -p /plugins/plugin-1 -t string -s whiskermenu --create
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -t int -s 1 --create

xfconf-query -c xfce4-whiskermenu-plugin -p /show-button-title -s false
xfconf-query -c xfce4-whiskermenu-plugin -p /show-app-icons -s true
xfconf-query -c xfce4-whiskermenu-plugin -p /show-category-icons -s true
xfconf-query -c xfce4-whiskermenu-plugin -p /show-recent -s true
xfconf-query -c xfce4-whiskermenu-plugin -p /recent-items-max -s 15
xfconf-query -c xfce4-whiskermenu-plugin -p /hover-switch-category -s true

xfconf-query -c xfce4-keyboard-shortcuts \
  -p "/commands/custom/<Super>Space" \
  -t string -s "xfce4-popup-whiskermenu" --create

pkill xfce4-panel || true

### ---------------- EWW ----------------
cat <<EOF > ~/.config/autostart/eww.desktop
[Desktop Entry]
Type=Application
Exec=eww daemon && eww open bar
Name=Eww
EOF

### ---------------- FIREFOX THEME ----------------
PROFILE=$(find ~/.mozilla/firefox -name "*.default-release" | head -n1)
if [ -n "$PROFILE" ]; then
  mkdir -p "$PROFILE/chrome"
  cp "$DIR/firefox/userChrome.css" "$PROFILE/chrome/" || true
  cp "$DIR/firefox/userContent.css" "$PROFILE/chrome/" || true

  cat <<EOF > "$PROFILE/user.js"
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("browser.tabs.drawInTitlebar", true);
user_pref("layout.css.color-mix.enabled", true);
EOF
fi

### ---------------- DONE ----------------
echo
echo "✅ INSTALL FINISHED"
echo "🔁 REBOOT NOW"
echo "🎨 XFCE → Appearance → Rose Pine"
echo "🪟 Super key → Windows-like menu"
echo
