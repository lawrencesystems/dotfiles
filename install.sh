#!/bin/bash

# Find all dot files then if the original file exists, create a backup
# Once backed up to {file}.dtbak symlink the new dotfile in place
for file in $(find . -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
done

# Install  vim-addons ZSH and ZSH extras
    echo "installing extras"
    sudo apt update && sudo apt -y install vim-scripts zsh zsh-syntax-highlighting zsh-autosuggestions

# Apply the changes and update the shell with the config files
exec bash

echo "Installed"
echo "use chsh -s /bin/zsh to switch to ZSH shell"


