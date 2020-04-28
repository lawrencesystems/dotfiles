#!/bin/bash

# Find all dot files then if the original file exists, create a backup
# Once backed up to {file}.dtbak symlink the new dotfile in place
for file in $(find . -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
done

# Check if vim-scripts installed, if not, install it automatically

if ! dpkg-query -W -f='${Status}' vim-scripts | grep "ok installed"; then
    echo "vim-scripts not installed, installing"
    sudo apt update && sudo apt -y install vim-scripts
else
    echo "vim-scripts already installed"
fi

# Check if NERDTree installed, if not, install it automatically

if [ ! -d ~/.vim/pack/vendor/start/nerdtree ]; then
    echo "NERDTree not installed, installing"
    git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
    vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
else
    echo "NERDTree already installed"
fi
echo "Installation Complete"
