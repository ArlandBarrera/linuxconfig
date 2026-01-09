# Configuration for Arch Linux

## ⚡️ Requirements

- git

## 🗂️ Packages

- Display Manager: ly.
- Desktop Environment/Window Manager: KDE Plasma.
- File Manager: yazi.
- Terminal Emulator: Kitty.
- Shell: Zsh.
- Browser: Zen Browser.
- Document Viewer: Zathura.
- e-book Manager: Calibre.
- Text Editor: Neovim.

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
sudo paru -S ly zen-browser-bin
```

## ⚙️ Configuration

### nvim

The neovim config can be found in [nvim](https://github.com/ArlandBarrera/nvim).
