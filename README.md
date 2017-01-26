#configs
=======

Useful configuration files for some linux utilities

##WARNINGS:
1) Make sure to clone INCLUDING submodules if you want vimrc to work properly:
git clone --recursive https://github.com/mkayyash/configs.git

2) To get vimrc working properly with its bundles then run the accompanying
prep_bundles.sh script.

3) Here are the steps needed to get ymc vim plugin working on mac.
This is assuming that vim, python, node, npm and llvm are installed from homebrew,
the main issue from following the official instructions on
https://github.com/Valloric/YouCompleteMe is that cmake attempts to use the system
python rather than the homebrew version when installing ycmd which causes vim
to crash as its opened with a python-related crash. A popular workaround is to run:
'export DYLD_FORCE_FLAT_NAMESPACE=1' before running vim but that is unnecessary hack
whereby the solution is to pass the python libraries to cmake via
'-DPYTHON_INCLUDE_DIR=/usr/local/Frameworks/Python.framework/Headers' and
'-DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Python'. Anyways here are
the instructions that have worked previously with my configuration:

   cd ~/.vim/bundles/ycm
   ./install.py --clang-completer --tern-completer
   cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/local/opt/llvm/ -DPYTHON_INCLUDE_DIR=/usr/local/Frameworks/Python.framework/Headers -DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Python . ~/.vim/bundle/ycm/third_party/ycmd/cpp/
   sudo cmake --build . --target ycm_core --config Release
   cd third_party/ycmd/third_party/tern_runtime
   npm install --production
   cd -
   cd ~/src/
   ln -s /Users/mkayyash/.vim/bundle/ycm/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py .
   cd configs
   ln -s ~/src/configs/tern-project ~/src/.tern-project
