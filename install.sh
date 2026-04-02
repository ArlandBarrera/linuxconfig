#!/bin/bash
# Author: Arland Barrera (aka takab)
# System: Arch Linux / EndeavourOS

set -e # Exit on error

DOTFILES_DIR=$(pwd)

echo "--- Starting System Configuration ---"

# 1. Essential & General Use Packages
echo "Installing base dependencies and tools..."
# Combined your specific list with the required build tools
sudo pacman -S --needed \
    zsh git curl unzip wget \
    zathura zathura-pdf-mupdf calibre \
    nodejs npm nvm neovim \
    yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf p7zip zoxide \
    imagemagick ttf-nerd-fonts-symbols chafa resvg \
    wl-clipboard xclip xsel \
    --noconfirm

# 2. Nerd Fonts (Meslo)
# Even though ttf-nerd-fonts-symbols is installed, we still sync your preferred Meslo
if [ ! -d ~/.local/share/fonts/Meslo ]; then
    echo "Downloading Meslo Nerd Font..."
    wget -P /tmp/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
    unzip /tmp/Meslo.zip -d /tmp/Meslo/
    mkdir -p ~/.local/share/fonts/Meslo
    cp /tmp/Meslo/MesloLGMN*.ttf ~/.local/share/fonts/Meslo/
    fc-cache -fv
    rm -rf /tmp/Meslo*
fi

# 3. Config Directories (Kitty, Yazi, Zathura)
echo "Syncing application configs..."
mkdir -p ~/.config
for app in kitty yazi zathura; do
    if [ -d "./$app" ]; then
        cp -r "./$app/" ~/.config/
        echo "Successfully copied $app config."
    fi
done

# 4. Neovim (Inloading)
if [ ! -d ~/.config/nvim ]; then
    echo "Cloning Neovim configuration..."
    git clone https://www.github.com/ArlandBarrera/nvim ~/.config/nvim/
fi

# 5. Zsh & Powerlevel10k Setup
echo "Configuring Zsh environment..."
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

# Create .zshrc with NVM and Zoxide support
cat <<EOF > ~/.zshrc
# p10k instant prompt
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${USER}.zsh"
fi

export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Added zoxide and nvm to plugins list
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting zoxide)

source \$ZSH/oh-my-zsh.sh

# Load NVM (Installed via pacman)
export NVM_DIR="\$HOME/.nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"

# fzf Keybindings for <C-t> and <C-r>
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# Initialize Zoxide
eval "\$(zoxide init zsh)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# 6. Finalize Shell Change (Fix for 'Shell not changed' error)
if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    echo "Fixing /etc/shells and applying Zsh..."
    grep -qxF "/usr/bin/zsh" /etc/shells || echo "/usr/bin/zsh" | sudo tee -a /etc/shells
    sudo chsh -s /usr/bin/zsh $USER
fi

echo "--- Setup Complete! Please reboot or log out. ---"
