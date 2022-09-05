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
# `packages_needed` is a map of binary to package name in reverse order.
packages_needed['redis-cli']='redis'
packages_needed['lua']='lua'
packages_needed['perl']='perl'
packages_needed['solidity-upgrade']='solidity'
packages_needed['sqlite3']='sqlite'
packages_needed['tmux']='tmux'
packages_needed['gcc']='gcc'
packages_needed['cscope']='cscope'
packages_needed['aws']='awscli'
packages_needed['python']='python'
packages_needed['ruby']='ruby'
packages_needed['gh']='gh'
packages_needed['git']='git'
packages_needed['nvim']='neovim'
packages_needed['ag']='ag'
packages_needed['rg']='rg'
packages_needed['ack']='ack'
packages_needed['fzf']='fzf'
packages_needed['ctags']='universal-ctags'
packages_needed['yarn']='yarn'
packages_needed['npm']='npm'
packages_needed['wget']='wget'
for key in "${!packages_needed[@]}"; do
  bin=$key
  package=${packages_needed[$key]}
  if ! command -v $bin &> /dev/null 
  then
    echo "Installing $package..."
    brew install $package
  fi
done

if ! command -v node &> /dev/null 
then
  echo "Installing Node JS through NVM"
  brew install nvm
  nvm install --lts
  nvm use --lts
  nvm alias default lts/*
fi

if ! command -v mongod &> /dev/null 
then
  echo "Installing MongoDB Community"
  brew tap mongodb/brew
  brew install mongodb-community
  brew services start mongodb-community
fi

if ! command -v fzf &> /dev/null 
then
  echo "Setting up FZF to work on the command line"
  $(brew --prefix)/opt/fzf/install
fi

if ! command -v gh &> /dev/null 
then
  echo "Authenticating Github. Login to Github..."
  gh auth login
fi

if [ ! -d "$HOME/src/configs" ]; then
  echo "Installing ~/src directory and configs repo"
  mkdir -p $HOME/src
  git clone https://github.com/mkayyash/configs.git $HOME/src
  grep -qxF "source ~/src/configs/general_bashrc.sh" $HOME/.bash_profile || echo "source ~/src/configs/general_bashrc.sh" | sudo tee -a $HOME/.bash_profile
  ln -s $HOME/src/configs/tmux.conf $HOME/.tmux.conf
fi

if ! grep -q "source ~/.vimrc" "$HOME/.config/nvim/init.vim"; then
  ln -s $HOME/src/configs/vimrc $HOME/.vimrc 2>/dev/null
  mkdir -p $HOME/.config/nvim
  touch $HOME/.config/nvim/init.vim
  echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after' > $HOME/.config/nvim/init.vim
  echo 'let &packpath = &runtimepath' >> $HOME/.config/nvim/init.vim
  echo 'source ~/.vimrc' >> $HOME/.config/nvim/init.vim
  pip3 install --user --upgrade neovim
  pip3 install --user --upgrade neovim-remote
  gem install neovim
  npm install -g neovim
fi

if [ ! -d "$HOME/.config/nvim/pack/minpac/opt/minpac" ]; then
  export PATH="$HOME/Library/Python/3.x/bin:$PATH"
  mkdir -p $HOME/.config/nvim/pack/minpac/opt
  git clone https://github.com/k-takata/minpac.git $HOME/.config/nvim/pack/minpac/opt/minpac
  nvim  -c ":call minpac#update('', {'do': 'quitall'})"
  cd $HOME/.vim/pack/minpac/start/coc.nvim/
  yarn install && yarn build
  nvim -c 'CocUpdateSync|quitall'
  ln -s $HOME/src/configs/coc-settings.json $HOME/.config/nvim/
  mkdir -p $HOME/.config/clangd
  ln -s $HOME/src/configs/clangd_config.yaml $HOME/.config/clangd/config.yaml
fi
