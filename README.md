# Configuration for Linux (Arch)

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

Install via script. Run `install.sh`, make sure to change file permissions to allow execute `chmod 744 install.sh`.

Install AUR helper (e.g. yay, paru) packages.

```bash
yay -S zen-browser-bin
```

## ⚙️ Configuration

### nvim

The neovim config can be found in it's dedicated repository [nvim](https://github.com/ArlandBarrera/nvim).
