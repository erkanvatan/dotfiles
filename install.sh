#!/bin/bash
DISTRO=${1^^} # turn to all uppercase
EMAIL=${2}

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "usage: sudo bash install.sh distro_name email_addr"
    exit 1
fi

case $DISTRO in
UBUNTU)
	echo installing for Ubuntu
	;;
*)
	echo not supported distro
    echo 'usage: sudo bash install.sh distro_name email_addr'
	exit 1
	;;
esac

TEMP_DIR=~/setup-temp
LOG_DIR=/tmp/system_install

# Empty log files
echo "" >$LOG_DIR/error.log
echo "" >$LOG_DIR/prezto.log
echo "" >$LOG_DIR/web_repos.log
echo "" >$LOG_DIR/npm.log
echo "" >$LOG_DIR/pipx.log

# Redirect stderr to error.log
exec 2>> $LOG_DIR/error.log

mkdir -p $LOG_DIR
mkdir -p $TEMP_DIR
cd $TEMP_DIR

echo 'running apt-get update'
apt-get -qq update
echo '> apt-get update finished'

### Global software installation using apt-get
echo '# GLOBAL SOFTWARE #'
echo 'installing apt apps'

apt-get -qq --yes install bat
apt-get -qq --yes install apt-file
apt-get -qq --yes install clangd
apt-get -qq --yes install curl
apt-get -qq --yes install fd-find
if [ -x "$(command -v git)" ]; then
    # Configure git for the first install
    apt-get -qq --yes install git
    git config --global user.name "$USERNAME"
    git config --global user.email "$EMAIL"
    git config --global color.ui true
    git config --global core.editor vim
else
    apt-get -qq --yes install git
fi

apt-get -qq --yes install grep
apt-get -qq --yes install ripgrep
apt-get -qq --yes install tidy
apt-get -qq --yes install translate-shell
apt-get -qq --yes install trash-cli
apt-get -qq --yes install unzip
apt-get -qq --yes install valgrind
apt-get -qq --yes install wget
apt-get -qq --yes install xclip
apt-get -qq --yes install xdg-utils
apt-get -qq --yes install subversion
apt-get -qq --yes install libgtk-3-dev
apt-get -qq --yes install neofetch
apt-get -qq --yes install zsh
apt-get -qq --yes install tmux
apt-get -qq --yes install ffmpeg

echo '> apt apps install finished'
echo 'installing pyenv dependencies'
apt-get -qq --yes install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
echo '> pyenv dependency install finished'
echo '> GLOBAL SOFTWARE FINISHED'

### Prezto installation using git
echo '# PREZTO #'

if ! [ -d "$HOME/.zprezto" ]; then
    echo 'installing prezto for zsh'
    exec 1>>$LOG_DIR/prezto.log
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    chsh -s /bin/zsh
    exec 1>/dev/tty # redirect stdout back to terminal
    echo '> prezto install finished'
else
    echo '.zprezto folder already exists, updating'
    zprezto-update >>$LOG_DIR/prezto.log
fi

echo '> PREZTO FINISHED'

### Downloading applications from their repos
echo '# REPOSITORIES FROM WEB #'
exec 1>>$LOG_DIR/web_repos.log

# install neovim
if ! [ -x "$(command -v nvim)" ]; then
    echo 'installing neovim' 1>/dev/tty
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "nvim"
    chmod u+x nvim
    mv nvim /usr/local/bin
else
    echo 'neovim already installed (check latest version from neovim/neovim github page!)' 1>/dev/tty
fi

# install nvm
if ! [ -x "$(command -v nvm)" ]; then
    echo 'installing nvm (v0.39.1)' 1>/dev/tty
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
    echo 'nvm already installed (check latest version from nvm-sh/nvm github page!)' 1>/dev/tty
fi

# install nodejs
if ! [ -x "$(command -v node)" ]; then
    echo 'installing latest LTS nodejs' 1>/dev/tty
    nvm install --lts
    nvm alias default node
    nvm use --lts
else
    echo 'nodejs already installed (check latest version from "nvm list" command!)' 1>/dev/tty
fi

# install pyenv
if ! [ -x "$(command -v pyenv)" ]; then
    echo 'installing latest pyenv' 1>/dev/tty
    # install pyenv using automatic installer
    curl -L https://github.com/psyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    exec $SHELL
    # install pyenv plugins
    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update

    git clone git://github.com/pyenv/pyenv-doctor.git $(pyenv root)/plugins/pyenv-doctor
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    git clone https://github.com/momo-lab/xxenv-latest.git "$(**env root)"/plugins/xxenv-latest
    pyenv update

    # install latest python version inside pyenv
    pyenv latest install
    pyenv latest global
else
    echo 'pyenv already installed, updating' 1>/dev/tty
    pyenv update
fi

# install pipx
if ! [ -x "$(command -v pipx)" ]; then
    echo 'installing latest pipx' 1>/dev/tty
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
else
    echo 'pipx already installed, updating' 1>/dev/tty
    python3 -m pip install --user -U pipx
fi

# install fzf
if ! [ -x "$(command -v fzf)" ]; then
    echo 'installing latest fzf' 1>/dev/tty
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo 'fzf already installed, updating' 1>/dev/tty
    cd ~/.fzf && git pull && ./install
    cd $TEMP_DIR
fi

exec 1>/dev/tty # redirect stdout back to terminal
echo '> REPOSITORIES FROM WEB FINISHED'

### Installing applications using npm
echo '# NPM APPS #'
exec 1>>$LOG_DIR/npm.log

if [ -x "$(command -v npm)" ]; then
    echo 'installing npm apps' 1>/dev/tty
    npm i -g --quiet livedown
    npm i -g --quiet live-server
    npm i -g --quiet http-server
    npm i -g --quiet neovim
    npm i -g --quiet tldr
    npm i -g --quiet sql-lint
    npm i -g --quiet wsl-open
    echo '> npm apps install finished' 1>/dev/tty
    echo 'updating npm apps' 1>/dev/tty
    npm i -g --quiet npm-check-updates
else
    echo 'npm not installed, could not install the apps' 1>/dev/tty
fi

exec 1>/dev/tty # redirect stdout back to terminal
echo '> NPM APPS FINISHED'

### Installing applications using pipx
echo '# PIPX APPS #'
exec 1>>$LOG_DIR/pipx.log

if [ -x "$(command -v pipx)" ]; then
    echo 'installing pipx apps' 1>/dev/tty
    pipx install yt-dlp
    pipx install flake8
    pipx install autopep8
    pipx install youtube-dl
    pipx install jedi-language-server
    pipx install pycodestyle
    echo '> pipx apps install finished' 1>/dev/tty

    echo 'updating pipx apps' 1>/dev/tty
    pipx upgrade-all
else
    echo 'pipx not installed, could not install the apps'
fi

exec 1>/dev/tty # redirect stdout back to terminal
echo '> PIPX APPS FINISHED'

### Configurations
echo '# CONFIGURATIONS #'

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo 'configuring SSH'
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C $EMAIL
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
else
    echo 'SSH already configured'
fi

echo '# CONFIGURATIONS FINISHED #'


rm -rf $TEMP_DIR

echo Purged temp folder

### Checking if apps are installed correctly
echo '# CHECKING INSTALLATIONS #'

echo '- nvim version:'
nvim --version
echo '- nvm version:'
nvm --version
echo '- node version:'
nvm list
echo '- pyenv check'
pyenv doctor
echo '- pipx version:'
pipx --version
echo '# CHECKING INSTALLATIONS FINISHED #'

### Reminder
echo REMEMBER TO:
echo - update all packages and the system
echo - register ssh public key to github
echo "-check $TMP_DIR for error logs"
echo '- download recommended font for powerlevel10k (MesloLGS NF)'
echo - reboot
