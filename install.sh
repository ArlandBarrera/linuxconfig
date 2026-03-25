# Author: Arland Barrera (aka takab)

# wallpaper
# planetary-suite-ii-by-steve-gildea
# https://suite3d.com

echo "copying config..."

# kitty

## nerdfont
wget -P ~/Downloads/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
unzip ~/Downloads/Meslo.zip -d ~/Downloads/Meslo/
mkdir -p ~/.local/share/fonts/
cp ~/Downloads/Meslo/MesloLGMN*.ttf ~/.local/share/fonts/
rm ~/Downloads/Meslo.zip
rm -r ~/Downloads/Meslo/

## kitty dir
cp -r ./kitty/ ~/.config/

# yazi
cp -r ./yazi/ ~/.config/

# zathura
cp -r ./zathura/ ~/.config/

# nvim

echo "\ninloading nvim config..."
git clone https://www.github.com/ArlandBarrera/nvim ~/.config/nvim/
echo "nvim config inloaded"

echo "\nconfig copied"
