#!/bin/bash

# Setup links so that dot files are loaded correctly
# Silva 03-11-2019

# Define the dotfiles to link
dotfiles=( bash_functions   bash_machine    bashrc         emacs          gitconfig      pythonrc       vimrc )

echo "Create folder for vim swaps at $HOME/.vim/swp" 
mkdir -p $HOME/.vim/swp # Create folder for vim swp files
# Create a hidden symbolic link in home to each dot file
for f in ${dotfiles[@]}
do
    echo "Linking $PWD/$f to $HOME/.$f"
    #ln -fs $PWD/$f $HOME/.$f # Override new links
    ln -s $PWD/$f $HOME/.$f
    echo ""
done
