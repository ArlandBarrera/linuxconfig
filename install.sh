# Author: Arland Barrera (aka takab)

echo "copying directories..."

# kitty
cp -r ./kitty/ ~/.config/

# yazi
cp -r ./yazi/ ~/.config/

# zathura
cp -r ./zathura/ ~/.config/

echo "directories copied"

# nvim

echo "\ninloading nvim config..."
git clone https://www.github.com/ArlandBarrera/nvim ~/.config/nvim/
echo "nvim config inloaded"
