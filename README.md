# Configuration for Arch Linux

## ⚡️ Requirements

- git

## 🗂️ Packages

- Display Manager: sddm.
- Desktop Environment/Window Manager: KDE Plasma.
- File Manager: yazi.
- Terminal Emulator: kitty.
- Shell: zsh.
- Browser: zen browser.
- Document Viewer: zathura.
- e-book Manager: calibre.
- Text Editor: neovim.

## 📦 Installation

Update system.

```bash
sudo pacman -Syu
```

Install pacman packages.

```bash
sudo pacman -S zathura zathura-pdf-mupdf calibre nodejs npm nvm neovim yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf p7zip zoxide imagemagick ttf-nerd-fonts-symbols chafa resvg wl-clipboard xclip xsel
```

Install AUR helper (e.g. yay, paru) packages.

```bash
yay -S zen-browser-bin
```

## ⚙️ Configuration

### nvim

The neovim config can be found in [nvim](https://github.com/ArlandBarrera/nvim).
