#!/usr/bin/env bash

############################################
# You should NOT run this file as SUDO.    #
# Running this with SUDO causes apps to be #
# installed in root home directory.        #
############################################

DISTRO=${1^^} # turn to all uppercase
EMAIL=${2}

if [ "$#" -ne 2 ]; then
    echo "E: Illegal number of parameters"
    echo "usage: bash install.sh distro_name email_addr"
    exit 1
fi

if  [ $(whoami) = "root" ]; then
    echo 'E: You should not run this file as SUDO'
    echo "usage: bash install.sh distro_name email_addr"
    exit 1
fi

case $DISTRO in
UBUNTU)
	echo '### INSTALLING FOR UBUNTU ###'
	;;
*)
	echo E: not supported distro
    echo "usage: bash install.sh distro_name email_addr"
	exit 1
	;;
esac

TEMP_DIR=$HOME/setup-temp
LOG_DIR=/tmp/system_install

# create needed directories
mkdir -p $LOG_DIR
mkdir -p $TEMP_DIR

mkdir -p $HOME/gist
mkdir -p $HOME/projects
mkdir -p $HOME/programs
# push user's directory onto stack
pushd $(pwd)
cd $TEMP_DIR

### Prezto installation using git
echo '### PREZTO ###'

if ! [ -d "$HOME/.zprezto" ]; then
    echo '# INSTALLING PREZTO FOR ZSH #'
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    echo '> PREZTO INSTALL FINISHED <'
else
    echo '# W: .ZPREZTO FOLDER ALREADY EXISTS, UPDATING #'
    zprezto-update
fi

echo '>>> PREZTO FINISHED <<<'

### Installing into ~/programs
echo '### INSTALLING INTO ~/programs ###'
pushd $(pwd)
cd $HOME/programs

# install swift-map for homerow computing
if [ ! -d "$HOME/programs/swift-map" ]; then
    echo '# INSTALLING SWIFT-MAP #'
    git clone "https://github.com/arensonzz/swift-map"
    pushd $(pwd)
    cd swift-map
    chmod +x mainloop.py

    echo '\tadd mainloop.py to system startup applications.'
    popd
    echo '> SWIFT-MAP INSTALL FINISHED <'
else
    echo '# W: SWIFT-MAP ALREADY INSTALLED #'
    echo '\tadd mainloop.py to system startup applications if swift-map is not working.'
fi


popd
echo '>>> INSTALLING INTO ~/programs FINISHED <<<'

### Downloading applications from their repos
echo '### REPOSITORIES FROM WEB ###'


# install neovim
if ! [ -x "$(command -v nvim)" ]; then
    echo '# INSTALLING NEOVIM #'
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "nvim"
    chmod u+x nvim
    sudo mv nvim /usr/local/bin
else
    echo '# W: NEOVIM ALREADY INSTALLED (CHECK LATEST VERSION FROM NEOVIM/NEOVIM GITHUB PAGE!) #'
fi

# install nvm
if ! [ -x "$(command -v nvm)" ]; then
    echo '# INSTALLING NVM (V0.39.1) #'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    # initialize nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    echo '# initialize nvm' >> $HOME/.bashrc
    echo \
'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> $HOME/.bashrc

else
    echo '# W: NVM ALREADY INSTALLED (CHECK LATEST VERSION FROM NVM-SH/NVM GITHUB PAGE!) #'
fi

# install nodejs
if ! [ -x "$(command -v node)" ]; then
    echo '# INSTALLING LATEST LTS NODEJS #'

    nvm install --lts
    nvm alias default node
    nvm use --lts
else
    echo '# W: NODEJS ALREADY INSTALLED (CHECK LATEST VERSION FROM "NVM LIST" COMMAND!) #'
fi

# install pyenv
if ! [ -x "$(command -v pyenv)" ]; then
    echo '# INSTALLING LATEST PYENV #'
    # install pyenv using automatic installer
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    # initialize pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    echo '# initialize pyenv' >> $HOME/.bashrc
    echo \
'export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)
' >> $HOME/.bashrc
    # install pyenv plugins
    git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest
    pyenv update
    # install latest python version inside pyenv
    pyenv latest install
    pyenv latest global
else
    echo '# W: PYENV ALREADY INSTALLED, UPDATING #'
    pyenv update
fi

# install pipx
if ! [ -x "$(command -v pipx)" ]; then
    echo '# INSTALLING LATEST PIPX #'
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    # initialize pipx
    #   Set pipx default python interpreter
    export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(pyenv version-name)/bin/python"
    #   Load pipx completions
    eval "$(register-python-argcomplete pipx)"

    echo '# initialize pipx' >> $HOME/.bashrc
    echo \
'#   Set pipx default python interpreter
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(pyenv version-name)/bin/python"
#   Load pipx completions
eval "$(register-python-argcomplete pipx)"
' >> $HOME/.bashrc
else
    echo '# W: PIPX ALREADY INSTALLED, UPDATING #'
    python3 -m pip install --user -U pipx
fi

# install fzf
if ! [ -x "$(command -v fzf)" ]; then
    echo '# INSTALLING LATEST FZF #'
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
    # initialize fzf
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    echo '# initialize fzf' >> $HOME/.bashrc
    echo \
'[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
' >> $HOME/.bashrc
else
    echo '# W: FZF ALREADY INSTALLED, UPDATING #'
    pushd $(pwd)
    cd $HOME/.fzf && git pull
    ./install
    popd
fi

echo '>>> REPOSITORIES FROM WEB FINISHED <<<'

### Installing applications using npm
echo '### NPM APPS ###'

if [ -x "$(command -v npm)" ]; then
    echo '# INSTALLING NPM APPS #'
    npm i -g --quiet livedown
    npm i -g --quiet live-server
    npm i -g --quiet http-server
    npm i -g --quiet neovim
    npm i -g --quiet tldr
    npm i -g --quiet sql-lint
    npm i -g --quiet wsl-open
    echo '> NPM APPS INSTALL FINISHED <'
    echo '# UPDATING NPM APPS #'
    npm i -g --quiet npm-check-updates
else
    echo '# E: NPM NOT INSTALLED, COULD NOT INSTALL THE APPS #'
fi

echo '>>> NPM APPS FINISHED <<<'

### Installing applications using pipx
echo '### PIPX APPS ###'

if [ -x "$(command -v pipx)" ]; then
    echo '# INSTALLING PIPX APPS #'
    pipx install yt-dlp
    pipx install flake8
    pipx install autopep8
    pipx install youtube-dl
    pipx install jedi-language-server
    pipx install pycodestyle
    echo '> PIPX APPS INSTALL FINISHED <'

    echo '# UPDATING PIPX APPS #'
    pipx upgrade-all
else
    echo '# E: PIPX NOT INSTALLED, COULD NOT INSTALL THE APPS #'
fi

echo '>>> PIPX APPS FINISHED <<<'

### Configurations
echo '### CONFIGURATIONS ###'

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    echo '# CONFIGURING SSH #'
	ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa -C $EMAIL
	eval "$(ssh-agent -s)"
	ssh-add $HOME/.ssh/id_rsa
else
    echo '# W: SSH ALREADY CONFIGURED #'
fi

echo '>>> CONFIGURATIONS FINISHED <<<'


rm -rf $TEMP_DIR

echo Purged temp folder

### Checking if apps are installed correctly
echo '### CHECKING INSTALLATIONS ###'

echo '- nvim version:'
nvim --version | head -n1
echo '- nvm version:'
nvm --version
echo '- node version:'
nvm list | head -n7
echo '- pyenv check'
pyenv doctor
echo '- pipx version:'
pipx --version
echo '- default python version:'
python --version
echo '>>> CHECKING INSTALLATIONS FINISHED <<<'

### Reminder
echo '### REMEMBER TO ###:'
echo - update all packages and the system
echo - register ssh public key to github
echo " -check $TMP_DIR for error logs"
echo '- download recommended font for powerlevel10k (MesloLGS NF)'
echo - reboot

# go back to user's directory
popd
