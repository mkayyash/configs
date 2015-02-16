#!/bin/bash
# Run first time to initialize the vim bundles. Preferably rm -rf ~/.vim before
# invoking the script.

conf_dir=$1

if [ ! -d "$1" ]; then
    conf_dir=~/src/configs
fi

if [ ! -d ~/.vim ]; then
    mkdir ~/.vim
fi

if [ ! -d ~/.vim/autoload ]; then
    mkdir ~/.vim/autoload
fi

if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
    ln -s $conf_dir/vimplugins/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
fi

if [ ! -d ~/.vim/bundle ]; then
    ln -s $conf_dir/vimplugins ~/.vim/bundle
fi

