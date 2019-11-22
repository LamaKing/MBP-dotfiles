#!/bin/bash

# Setup links so that dot files are loaded correctly
# Silva 22-11-2019

# Define the dotfiles to link
dotfiles=( bash_functions   bashrc         emacs          gitconfig      pythonrc       vimrc )

# Create a hidden symbolic link in home to each dot file
for f in ${dotfiles[@]}
do
    echo "Linking $f to $HOME/.$f"
    # Add -f to overwrite existing files or links
    ln -s $PWD/$f $HOME/.$f
    echo ""
done

# Custom ones
ln -s $PWD/etc/ssh_config $HOME/.ssh/config
ln -s $PWD/etc/bash_machine $HOME/.bash_machine
