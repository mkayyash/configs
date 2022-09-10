#!/usr/bin/env bash

shopt -s expand_aliases
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if [ $("uname") == "Darwin" ]
then
  export PATH=/opt/homebrew/bin:$PATH
  if ! command -v brew &> /dev/null
  then
    echo "Homebrew not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "Updating XCode command line tools"
    softwareupdate --all --install --force
  fi
  alias package_install="brew install"
  alias YARN="yarn"
  export BASHRC=$HOME/.bash_profile
  touch BASHRC
else
  alias package_install="sudo apt-get -y install"
  alias YARN="yarnpkg"
  export BASHRC=$HOME/.bashrc
fi

if [ $(version $BASH_VERSION) -lt $(version 5.0.0) ]; then
  echo "Must have bash version of 5.0.0+."
  package_install bash
  grep -qxF $(command -v bash&) /etc/shells || echo $(command -v bash&) | sudo tee -a /etc/shells
  chsh -s $(command -v bash&)
  sudo chsh -s $(command -v bash&)
  echo "NOTE: Bash 5.0+ installed. Restart this script in a new shell to continue."
  exit 1
fi

declare -A packages_needed
# We install these packages if they are not already installed.
# `packages_needed` is a map of binary to package name in reverse order.
packages_needed['perl']='perl'
packages_needed['sqlite3']='sqlite3'
packages_needed['tmux']='tmux'
packages_needed['gcc']='gcc'
packages_needed['cscope']='cscope'
packages_needed['python3']='python3'
packages_needed['rustc']='rust'
packages_needed['git']='git'
packages_needed['nvim']='neovim'
packages_needed['rg']='ripgrep'
packages_needed['ack']='ack'
packages_needed['fzf']='fzf'
packages_needed['npm']='npm'
packages_needed['wget']='wget'
packages_needed['curl']='curl'
if [ $("uname") == "Darwin" ]
then
  packages_needed['ruby']='ruby'
  packages_needed['lua']='lua'
  packages_needed['ag']='ag'
  packages_needed['yarn']='yarn'
  packages_needed['ctags']='universal-ctags'
else
  packages_needed['ruby']='ruby-dev'
  packages_needed['pip3']='python3-pip'
  packages_needed['lua']='lua5.3'
  packages_needed['ag']='silversearcher-ag'
  packages_needed['yarnpkg']='yarnpkg'
  packages_needed['ctags']='exuberant-ctags'
fi
for key in "${!packages_needed[@]}"; do
  bin=$key
  package=${packages_needed[$key]}
  if ! command -v $bin &> /dev/null
  then
    echo "Installing $package..."
    package_install $package
  fi
done

if ! command -v solc &> /dev/null
then
  if [ $("uname") == "Darwin" ]
  then
    brew tap ethereum/ethereum
    brew install solidity
  else
    sudo add-apt-repository -y ppa:ethereum/ethereum
    sudo apt-get -y update
    sudo apt-get -y install solc
  fi
fi

if ! command -v gh &> /dev/null
then
  if [ $("uname") == "Darwin" ]
  then
    brew install gh
  else
    sudo apt-get install gh
  fi
  echo "Authenticating Github. Login to Github..."
  gh auth login
fi

if ! command -v node &> /dev/null
then
  echo "Installing Node JS through NVM"
  if [ $("uname") == "Darwin" ]
  then
    package_install nvm
  else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    source $BASHRC
  fi
  nvm install --lts
  nvm use --lts
  nvm alias default lts/*
fi

if ! command -v fzf &> /dev/null
then
  echo "Setting up FZF to work on the command line"
  if [ $("uname") == "Darwin" ]
  then
    $(brew --prefix)/opt/fzf/install
  fi
fi

if [ ! -d "$HOME/src/configs" ]; then
  echo "Installing ~/src directory and configs repo"
  mkdir -p $HOME/src
  git clone https://github.com/mkayyash/configs.git $HOME/src/configs
fi

grep -qxF "source ~/src/configs/general_bashrc.sh" $BASHRC || echo "source ~/src/configs/general_bashrc.sh" | sudo tee -a $BASHRC
source $BASHRC
ln -s $HOME/src/configs/tmux.conf $HOME/.tmux.conf 2>/dev/null

# Check is not super robust so may need to comment the if statement out and just
# run this code anyways.
if ! grep -q "source ~/.vimrc" "$HOME/.config/nvim/init.vim"; then
  if [ ! -f "$HOME/.vimrc" ]; then
    ln -s $HOME/src/configs/vimrc $HOME/.vimrc 2>/dev/null
  else
    grep -qxF "source ~/src/configs/vimrc" $HOME/.vimrc || echo "source ~/src/configs/vimrc" | sudo tee -a $HOME/.vimrc
  fi
  mkdir -p $HOME/.config/nvim
  touch $HOME/.config/nvim/init.vim
  echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after' > $HOME/.config/nvim/init.vim
  echo 'let &packpath = &runtimepath' >> $HOME/.config/nvim/init.vim
  echo 'source ~/.vimrc' >> $HOME/.config/nvim/init.vim
  pip3 install --user --upgrade neovim
  pip3 install --user --upgrade neovim-remote
  sudo gem install neovim
  sudo npm install -g neovim
fi

# Check is not super robust so may need to comment the if statement out and just
# run this code anyways.
if [ ! -d "$HOME/.config/nvim/pack/minpac/opt/minpac" ]; then
  export PATH="$HOME/Library/Python/3.x/bin:$PATH"
  mkdir -p $HOME/.config/nvim/pack/minpac/opt
  git clone https://github.com/k-takata/minpac.git $HOME/.config/nvim/pack/minpac/opt/minpac
  # TODO(mkayyash): Check the output directory $HOME/.vim/ for installed packages
  # to decide if we should run this minpac install (more robust).
  nvim  -c ":call minpac#update('', {'do': 'quitall'})"
  cd $HOME/.vim/pack/minpac/start/coc.nvim/
  npm i --save esbuild
  YARN install && YARN build
  nvim -c 'CocUpdateSync|quitall'
  ln -s $HOME/src/configs/coc-settings.json $HOME/.config/nvim/ 2>/dev/null
  mkdir -p $HOME/.config/clangd
  ln -s $HOME/src/configs/clangd_config.yaml $HOME/.config/clangd/config.yaml 2>/dev/null
fi
