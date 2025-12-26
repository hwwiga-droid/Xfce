# Xfce
Arch xfce dotfiles rice
# Rose Pine XFCE for Arch Linux

A full **one-click installer** to replicate the **Linux Mint XFCE Rosé Pine rice**
on **Arch Linux + XFCE**, including UI, themes, shell, bar, dock, compositor,
and a Windows-like Start menu.

> Built and maintained by **Hamed Abdolahi**

---

## 📸 Preview

This setup is visually and functionally based on the original
**LinuxMint-XFCE-RosePine** rice.
After installation, the desktop closely matches the screenshots and behavior
shown in the original repository.

---

## ✨ Features

- 🎨 **Rosé Pine GTK Theme**
- 🧩 **Papirus Icon Theme**
- 🌫️ **Picom** (blur, shadows, transparency)
- 📊 **Eww bar** (top bar)
- 🚀 **Plank dock**
- 🪟 **Windows-like Start Menu** (XFCE Whisker Menu)
  - Open with **Super (Win) key**
  - Search, categories, recent apps
- 🐚 **Fish shell**
- ✨ **Oh My Posh prompt**
- 🖥️ **Neofetch on terminal launch**
- 🦊 **Firefox fully themed** (userChrome.css + userContent.css)
- ⚙️ Fully automated via **single shell script**

---

## 🧱 Components Installed

### System packages
- xfce4 / xfce4-goodies
- xfce4-whiskermenu-plugin
- picom
- fish
- plank
- firefox
- alacritty
- neovim
- neofetch
- gtk-engine-murrine
- papirus-icon-theme

### AUR packages
- eww
- oh-my-posh-bin
- rose-pine-gtk-theme

---

## 📦 What the installer does

✔ Updates the system  
✔ Installs all required packages (pacman + AUR)  
✔ Clones the original rice repository  
✔ Copies all configs, themes, icons, and local files  
✔ Sets **fish** as default shell  
✔ Enables **picom**, **eww**, and **plank** at startup  
✔ Configures **XFCE panel** (minimal)  
✔ Enables **Whisker Menu** (Windows-style Start Menu)  
✔ Binds **Super key** to open the menu  
✔ Applies **Firefox Rosé Pine theme automatically**

---

## 🚀 Installation

### 1. Clone this repository
```bash
git clone httprosepine-xfce-arch
