#!/bin/bash

# Setup links so that dot files are loaded correctly
# Silva 03-11-2019

# Define the dotfiles to link
dotfiles=( bash_functions   bash_machine    bashrc         emacs          gitconfig      pythonrc       vimrc )

# Create a hidden symbolic link in home to each dot file
for f in ${dotfiles[@]}
do
    echo "Linking $f to $HOME/.$f"
    ln -s $PWD/$f $HOME/.$f
    echo ""
done
