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
alias en="vim ~/Notes"

alias all_pkg='dpkg --get-selections | grep -v deinstall'
alias more='less '
alias rswap='rm .*.swp;rm .*.swn;rm .*.swo'
alias genj_jar='rm src/j.jar; rm src/com/dogcows/*.class ;  javac -cp ".:ContestApplet.jar" src/com/dogcows/Editor.java src/com/dogcows/VimCoder.java src/com/dogcows/Util.java ; cd src/ ; jar cf j.jar com ; cd ..'

alias pgit="git log --color --graph --pretty=format:'%Cred%h%Creset %Cblue%an%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"

if [ $("uname") == "Darwin" ]
then
    alias sbash='source ~/.bash_profile'
    alias ack-grep="ack"
    # make bash completion work (e.g. for git).
    # Note must setup first via: brew install git bash-completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
else
    alias sbash='source ~/.bashrc'
fi

