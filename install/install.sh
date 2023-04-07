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
pushd $TEMP_DIR >/dev/null

### Prezto installation using git
echo '### PREZTO ###'

if ! [ -d "$HOME/.zprezto" ]; then
    echo '# INSTALLING PREZTO FOR ZSH #'
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    echo '> PREZTO INSTALL FINISHED <'
else
    echo '# W: .ZPREZTO FOLDER ALREADY EXISTS, UPDATE BY RUNNING: #'
    printf '\tzprezto-update\n'
fi

echo '>>> PREZTO FINISHED <<<'

### Installing into ~/programs
echo '### INSTALLING INTO ~/programs ###'
pushd $HOME/programs >/dev/null

# install swift-map for homerow computing
if [ ! -d "$HOME/programs/swift-map" ]; then
    echo '# INSTALLING SWIFT-MAP #'
    git clone "https://github.com/arensonzz/swift-map"
    pushd swift-map >/dev/null
    chmod +x mainloop.py

    printf '\tadd mainloop.py to system startup applications.\n'
    popd >/dev/null
    echo '> SWIFT-MAP INSTALL FINISHED <'
else
    echo '# W: SWIFT-MAP ALREADY INSTALLED #'
    printf '\tadd mainloop.py to system startup applications if swift-map is not working.\n'
fi

if [ ! -d "$HOME/programs/core" ]; then
    echo '# INSTALLING WMUTILS/CORE #'
    git clone "https://github.com/wmutils/core.git"
    pushd core >/dev/null
    make
    sudo make install

    popd >/dev/null
    echo '> WMUTILS INSTALL FINISHED <'
else
    echo '# W: WMUTILS ALREADY INSTALLED #'
fi

popd >/dev/null
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

# install TPM (Tmux Package Manager)
if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo '# INSTALLING TPM (Tmux Package Manager) #'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
else
    echo '# W: TPM (Tmux Package Manager) ALREADY INSTALLED, UPDATING #'
    pushd $HOME/.tmux/plugins/tpm >/dev/null && git pull && ~/.tmux/plugins/tpm/bin/install_plugins
    popd >/dev/null
fi

# install nvm
if ! [ -d "$HOME/.nvm" ]; then
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
if ! [ -d "$HOME/.pyenv" ]; then
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
eval "$(pyenv virtualenv-init -)"
' >> $HOME/.bashrc
    # install pyenv plugins
    git clone https://github.com/alefpereira/pyenv-pyright.git $(pyenv root)/plugins/pyenv-pyright
    pyenv update
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
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash

    echo '# initialize fzf' >> $HOME/.bashrc
    echo \
'[ -f ~/.fzf.bash ] && source ~/.fzf.bash
' >> $HOME/.bashrc
else
    echo '# W: FZF ALREADY INSTALLED #'
    printf 'You can update by calling:\n\tcd $HOME/.fzf && git pull\n\t./install\n'
fi

# install calibre
if ! [ -x "$(command -v calibre)" ]; then
    echo '# INSTALLING LATEST CALIBRE #'
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
else
    echo '# W: CALIBRE ALREADY INSTALLED #'
fi

echo '>>> REPOSITORIES FROM WEB FINISHED <<<'

# install discord
if ! [ -x "$(command -v discord)" ]; then
    echo '# INSTALLING LATEST DISCORD #'
    sudo -v
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo gdebi discord.deb
else
    echo '# W: DISCORD ALREADY INSTALLED #'
fi

# install zoom
if ! [ -x "$(command -v zoom)" ]; then
    echo '# INSTALLING LATEST ZOOM #'
    sudo -v
    wget -O zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    sudo gdebi zoom.deb
else
    echo '# W: ZOOM ALREADY INSTALLED #'
fi

# install rustup
# if ! [ -x "$(command -v rustup)" ]; then
    # echo '# INSTALLING RUSTUP #'
    # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # source $HOME/.cargo/env
# else
    # echo '# W: RUSTUP ALREADY INSTALLED #'
# fi


### Installing applications using npm
echo '### NPM APPS ###'

if [ -x "$(command -v npm)" ]; then
    echo '# INSTALLING NPM APPS #'

    if ! [ -x "$(command -v livedown)" ]; then
        npm i -g --quiet livedown
    fi

    if ! [ -x "$(command -v live-server)" ]; then
        npm i -g --quiet live-server
    fi

    # if the package is not executable then check using this snippet
    if [ `npm list -g | grep -c neovim` -eq 0 ]; then
        npm i -g --quiet neovim
    fi

    if ! [ -x "$(command -v tldr)" ]; then
        npm i -g --quiet tldr
    fi

    if ! [ -x "$(command -v sql-lint)" ]; then
        npm i -g --quiet sql-lint
    fi

    # if ! [ -x "$(command -v wsl-open)" ]; then
        # npm i -g --quiet wsl-open
    # fi

    # if ! [ -x "$(command -v degit)" ]; then
        # npm i -g --quiet degit
    # fi

    if ! [ -x "$(command -v js-beautify)" ]; then
        npm i -g --quiet js-beautify
    fi

    if ! [ -x "$(command -v sass)" ]; then
        npm i -g --quiet sass
    fi

    # if the package is not executable then check using this snippet
    # if [ `npm list -g | grep -c svelte-language-server` -eq 0 ]; then
        # npm i -g --quiet svelte-language-server
    # fi
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
    pipx install jedi-language-server
    pipx install pycodestyle
    pipx install pipreqs
    pipx install cmake-language-server
    echo '> PIPX APPS INSTALL FINISHED <'

    echo '# UPDATING PIPX APPS #'
    pipx upgrade-all
else
    echo '# E: PIPX NOT INSTALLED, COULD NOT INSTALL THE APPS #'
fi

echo '>>> PIPX APPS FINISHED <<<'

### Installing and updating applications using pip
echo '### PIP APPS ###'

if [ -x "$(command -v pip3)" ]; then
    echo '# INSTALLING OR UPDATING PIP APPS #'

    if [ `pip3 list | grep -c pynvim` -eq 0 ]; then
        pip3 install pynvim
    else
        pip3 install --upgrade pynvim
    fi
    echo '> PIP APPS INSTALL FINISHED <'
else
    echo '# E: PIP NOT INSTALLED, COULD NOT INSTALL THE APPS #'
fi

echo '>>> PIP APPS FINISHED <<<'

### Installing and updating applications using cargo
echo '### CARGO APPS ###'
cargo install alacritty
echo '>>> CARGO APPS FINISHED <<<'

### Installing rustup components
# echo '### RUSTUP COMPONENTS ###'
# rustup component add rusfmt
# echo '>>> RUSTUP COMPONENTS FINISHED <<<'

### Installing and updating applications using flatpak
echo '### FLATPAK APPS ###'
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak update --appstream # update repository
# flatpak install -y flathub fr.handbrake.ghb
# flatpak install -y flathub org.kde.okular
# flatpak install -y flathub org.gimp.GIMP

echo '> FLATPAK APPS FINISHED <'

### Configurations
echo '### CONFIGURATIONS ###'

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    echo '# CONFIGURING SSH #'
	ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa -C $EMAIL
	eval "$(ssh-agent -s)"
	ssh-add $HOME/.ssh/id_rsa
    echo '# CONFIGURED SSH#'
    printf '\tregister ssh public key to GitHub\n'
else
    echo '# W: SSH ALREADY CONFIGURED #'
fi

echo '>>> CONFIGURATIONS FINISHED <<<'

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

# go back to user's directory
popd >/dev/null
rm -rf $TEMP_DIR
echo '# PURGED TEMP FOLDER #'

### Reminder
echo '### REMEMBER TO ###:'
echo '- update all packages and the system'
echo '  * Update zprezto by calling: zprezto-update'
echo '  * Check latest Neovim version from: https://github.com/neovim/neovim/releases/latest'
echo '  * Check latest NVM version from: https://github.com/nvm-sh/nvm/releases/latest'
echo '  * Check latest Node.js version from: nvm list'
printf '  * Update fzf by calling:\n\tcd $HOME/.fzf && git pull\n\t./install\n'
echo '  * Update pip3 by calling: pip3 install --upgrade pip'
echo '  * Update npm by calling: '
printf '  * Update npm by calling:\n\tnpm install -g npm@latest\n'
echo '- install following apps'
echo '  * ProtonVPN: https://protonvpn.com/support/linux-ubuntu-vpn-setup/'
echo '  * Anki: https://apps.ankiweb.net/#download'
echo '  * VirtualBox: https://www.virtualbox.org/wiki/Linux_Downloads'
echo '  * Telegram: https://telegram.org/dl/desktop/linux'
echo '  * scrcpy: https://github.com/Genymobile/scrcpy/blob/master/BUILD.md#simple'
echo '  * drawio: https://github.com/jgraph/drawio-desktop/releases'
echo '  * texlive-full: https://gist.github.com/wkrea/b91e3d14f35d741cf6b05e57dfad8faf'
echo '  * sqlectron: https://github.com/sqlectron/sqlectron-gui/releases/latest'
echo '  * winehq: https://wiki.winehq.org/Ubuntu'
echo '  * JMeter: https://jmeter.apache.org/download_jmeter.cgi'
echo '  * Postman: https://dl.pstmn.io/download/latest/linux64'
echo '  * Jetbrains Rider: https://www.jetbrains.com/rider/download/'
echo '  * Teams Preview: https://go.microsoft.com/fwlink/p/?LinkID=2112886&culture=en-us&country=WW'
echo '  * Ventoy: https://www.ventoy.net/en/download.html'
echo '  * ngrok: https://ngrok.com/download'
echo '  * xpadneo: https://github.com/atar-axis/xpadneo#prerequisites'
echo '  * PhotoGIMP: https://github.com/Diolinux/PhotoGIMP#-how-to-install-others'
echo '  * asus-fan-control: https://github.com/dominiksalvet/asus-fan-control'
echo '-- zsh external plugins'
echo '  * zsh-z: https://github.com/agkozak/zsh-z#installation'


