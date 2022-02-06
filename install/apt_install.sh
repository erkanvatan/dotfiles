#!/usr/bin/env bash

####################################
# You should run this file as SUDO #
####################################

DISTRO=${1^^} # turn to all uppercase
EMAIL=${2}
USER_HOME="$(getent passwd $SUDO_USER | cut -d: -f6)"

if [ "$#" -ne 2 ]; then
    echo "E: Illegal number of parameters"
    echo "usage: sudo bash apt_install.sh distro_name email_addr"
    exit 1
fi

if [ $(whoami) != "root" ]; then
    echo 'E: You should run this file as SUDO'
    echo "usage: sudo bash apt_install.sh distro_name email_addr"
    exit 1
fi

case $DISTRO in
UBUNTU)
	echo '### INSTALLING FOR UBUNTU ###'
	;;
*)
	echo E: not supported distro
    echo 'usage: sudo bash apt_install.sh distro_name email_addr'
	exit 1
	;;
esac

TEMP_DIR=$HOME/setup-temp
LOG_DIR=/tmp/system_install

mkdir -p $LOG_DIR
mkdir -p $TEMP_DIR
# Empty log files
echo "" >$LOG_DIR/apt_install.log

exec 1>$LOG_DIR/apt_install.log

# push user's directory onto stack
pushd $(pwd)
cd $TEMP_DIR

echo '# RUNNING APT-GET UPDATE #' 1>/dev/tty
apt-get --yes update 1>/dev/tty
echo '> APT-GET UPDATE FINISHED <' 1>/dev/tty

### Global software installation using apt-get
echo '### GLOBAL SOFTWARE ###' 1>/dev/tty
echo '# INSTALLING APT APPS #' 1>/dev/tty

apt-get -qq --yes install bat
apt-get -qq --yes install apt-file
apt-get -qq --yes install clangd
apt-get -qq --yes install curl
apt-get -qq --yes install fd-find
if ! [ -x "$(command -v git)" ]; then
    # Configure git for the first install
    apt-get -qq --yes install git
    git config --global user.name "$(whoami)"
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
if ! [ -x "$(command -v zsh)" ]; then
    # Configure zsh for the first install
    apt-get -qq --yes install zsh
    echo "Changing default shell to ZSH." 1>/dev/tty
    chsh -s $(which zsh) $(whoami) 1>/dev/tty
    echo "W: Please logout after for default shell change to take effect." 1>/dev/tty
else
    apt-get -qq --yes install zsh
fi

apt-get -qq --yes install tmux
apt-get -qq --yes install ffmpeg
apt-get -qq --yes install python3-pip

echo '> APT APPS INSTALL FINISHED <' 1>/dev/tty
echo '# INSTALLING PYENV DEPENDENCIES #' 1>/dev/tty
apt-get -qq --yes install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
echo '> PYENV DEPENDENCY INSTALL FINISHED <' 1>/dev/tty
echo '### GLOBAL SOFTWARE FINISHED ###' 1>/dev/tty
