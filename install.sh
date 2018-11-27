#!/bin/bash
for file in $(find . -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
    ln -s $PWD/.bash ~/.bash
done
 if hash vim-addon  2>/dev/null; then
         echo "vim-addon (vim-scripts)  installed"
     else
         echo "vim-addon (vim-scripts) not installed, running 'sudo apt update; sudo apt install bc'"
         sudo apt update; sudo apt install vim-scripts
fi

echo "Installed"
