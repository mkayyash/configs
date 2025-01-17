#!/bin/bash
# INCLUDE IN ~/.bashrc (linux) or ~/.bash_profile (darwin) by
# appending the following line to that file:
# source <PATH>/configs/general_bashrc.sh

# A few grep search functions.
# TODO(mkayyash): Make it more generic.
cs_gen ()
{
  grep -rl "$1" . 2>/dev/null
}

cs_c ()
{
  grep -rl "$1" --include=\*.{h,c,cpp} . 2>/dev/null
}
cs_ic ()
{
  grep -ril "$1" --include=\*.{h,c} . 2>/dev/null
}
cs_amk ()
{
  grep -rl "$1" --include=\*.{mk} . 2>/dev/null
}
cs_cpp ()
{
  grep -rl "$1" --include=\*.{h,cpp} . 2>/dev/null
}

function rand() {
    local length=$1
    tr -cd '[:alnum:]' < /dev/urandom | fold -w$length | head -n1
}

function nice_rm() {
    local dir=$1
    local newdir=.$(rand 30)
    mv $dir $newdir
    rm -rf $newdir &
}

function ker_details() {
    local file=$1
    dd if=$file bs=1 skip=$(LC_ALL=C grep -a -b -o $'\x1f\x8b\x08\x00\x00\x00\x00\x00' $file | cut -d ':' -f 1) | zgrep -a 'Linux version'
}

function alladb() {
    x=`adb devices | grep  device$ | awk '{print $1}' `

    for i in $x; do
        echo "==========="
        echo "Running adb -s $i $@"
        echo "==========="
        adb -s $i $@
        echo ""
    done
}

alias fd='find . 2>/dev/null | grep '
alias h='history | grep'
alias en="vim ~/Notes.md"

alias all_pkg='dpkg --get-selections | grep -v deinstall'
alias more='less '
alias rswap='rm .*.swp;rm .*.swn;rm .*.swo'
alias genj_jar='rm src/j.jar; rm src/com/dogcows/*.class ;  javac -cp ".:ContestApplet.jar" src/com/dogcows/Editor.java src/com/dogcows/VimCoder.java src/com/dogcows/Util.java ; cd src/ ; jar cf j.jar com ; cd ..'

alias pgit="git log --color --graph --pretty=format:'%Cred%h%Creset %Cblue%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"

if [ $("uname") == "Darwin" ]
then
    alias sbash='source ~/.bash_profile'
    alias ack-grep="ack"
    export PATH=/opt/homebrew/bin:$PATH
    # make bash completion work (e.g. for git).
    # Note must setup first via: brew install git bash-completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
else
    alias sbash='source ~/.bashrc'
fi

alias ripgrep="rg"

# Use Neovim as "preferred editor"
export EDITOR=nvim
export VISUAL=nvim
# Use Neovim instead of Vim or Vi
alias vim=nvim
alias vi=nvim

# Colorized ls
alias ls="ls -G"

# Google
alias blaze=bazel

#export VIMCONFIG=~/.vim
#export VIMDATA=~/.vim
export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim

#Increase bash history size (default is 500 on mac)
HISTSIZE=20000
HISTFILESIZE=20000

#Fix colors in terminal (for example when doing ls ~/)
export CLICOLOR=1
export LSCOLORS=cxfxdxdxhxegedabagacad

if [ $("uname") == "Darwin" ]
then
    # hide the stupid mac catalina warning about switching to zsh
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # required by nvm installation on MAC
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
    export NODE_PATH=/usr/lib/nodejs:/usr/share/nodejs
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

#Python 3 is the default
alias python=python3
alias pip=pip3
