#!/bin/bash
# Author: Arland Barrera (aka takab)
# System: Arch Linux / EndeavourOS

set -e # Exit on error

DOTFILES_DIR=$(pwd)

echo "--- Starting System Configuration ---"

# 1. Essential Packages & Fonts
echo "Installing base dependencies and Nerd Fonts..."
# On Arch, ttf-meslo-nerd is in the repos/AUR, but we'll stick to a clean pacman sync for others
sudo pacman -S --needed zsh fzf git curl unzip zathura yazi kitty --noconfirm

# Check if Meslo is already installed to skip heavy downloads
if [ ! -d ~/.local/share/fonts/Meslo ]; then
    echo "Downloading Meslo Nerd Font..."
    wget -P /tmp/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
    unzip /tmp/Meslo.zip -d /tmp/Meslo/
    mkdir -p ~/.local/share/fonts/Meslo
    cp /tmp/Meslo/MesloLGMN*.ttf ~/.local/share/fonts/Meslo/
    fc-cache -fv
    rm -rf /tmp/Meslo*
fi

# 2. Config Directories (Kitty, Yazi, Zathura)
echo "Syncing terminal and file manager configs..."
mkdir -p ~/.config
for app in kitty yazi zathura; do
    if [ -d "./$app" ]; then
        cp -r "./$app/" ~/.config/
        echo "Successfully copied $app config."
    fi
done

# 3. Neovim (Inloading)
if [ ! -d ~/.config/nvim ]; then
    echo "Cloning Neovim configuration..."
    git clone https://www.github.com/ArlandBarrera/nvim ~/.config/nvim/
else
    echo "Nvim config already exists, skipping clone."
fi

# 4. Zsh & Powerlevel10k Setup
echo "Configuring Zsh..."

# Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Clone Theme & Plugins
[[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Deploy .zshrc and .p10k.zsh
cp "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

cat <<EOF > ~/.zshrc
# p10k instant prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh"
fi

export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

source \$ZSH/oh-my-zsh.sh

# fzf Keybindings for <C-t> and <C-r>
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# 5. Finalize
if [[ "$SHELL" != */zsh ]]; then
    sudo chsh -s $(which zsh) $USER
fi

echo "--- Setup Complete! Please restart your session. ---"
