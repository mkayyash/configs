#!/usr/bin/env bash
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if ! command -v brew &> /dev/null
then
  echo "Homebrew not installed. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo "Updating XCode command line tools"
  softwareupdate --all --install --force
fi

if [ $(version $BASH_VERSION) -lt $(version 5.0.0) ]; then
  echo "Must have bash version of 5.0.0+."
  brew install bash
  grep -qxF $(command -v bash&) /etc/shells || echo $(command -v bash&) | sudo tee -a /etc/shells
  chsh -s $(command -v bash&)
  sudo chsh -s $(command -v bash&)
  echo "NOTE: Bash 5.0+ installed. Restart this script in a new shell to continue."
  exit 1
fi

declare -A packages_needed
# We install these packages if they are not already installed.
# `packages_needed` is a map of cask to package path in reverse order.
packages_needed['iterm2']='/Applications/iTerm.app'
packages_needed['meld']='/Applications/Meld.app'
for key in "${!packages_needed[@]}"; do
  cask=$key
  dir=${packages_needed[$key]}
  if [ ! -d $dir ]; then
    echo "Installing $cask..."
    brew install --cask $cask
  fi
done

brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font

ln -s ~/src/configs/iTerm.json $HOME/Library/Application\ Support/iTerm2/DynamicProfiles/iTerm.json2>/dev/null
