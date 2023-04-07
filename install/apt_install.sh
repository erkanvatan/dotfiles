#https://www.jetbrains.com/rider/download/!/usr/bin/env bash

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
pushd $TEMP_DIR >/dev/null

echo '# ADDING PPA REPOS #' 1>/dev/tty
# cherrytree
add-apt-repository -y ppa:giuspen/ppa
# crow-translate
add-apt-repository -y ppa:jonmagon/crow-translate
# open broadcaster software (obs-studio)
add-apt-repository -y ppa:obsproject/obs-studio
# openshot
add-apt-repository -y ppa:openshot.developers/ppa
# tlp
add-apt-repository -y ppa:linrunner/tlp
# tlpui
add-apt-repository -y ppa:linuxuprising/apps
# quod libet
add-apt-repository -y ppa:lazka/ppa


echo '> ADDED PPA REPOS <' 1>/dev/tty

echo '# RUNNING APT-GET UPDATE #' 1>/dev/tty
apt-get --yes update 1>/dev/tty
echo '> APT-GET UPDATE FINISHED <' 1>/dev/tty

### Global software installation
echo '### GLOBAL SOFTWARE ###' 1>/dev/tty
echo '# INSTALLING APT APPS #' 1>/dev/tty

# CLI APPS
#   package managers
apt-get -qq --yes install cargo
apt-get -qq --yes install python3-pip
apt-get -qq --yes install flatpak

#
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
# apt-get -qq --yes install ripgrep
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
    echo "Run following command to change default shell to ZSH:" 1>/dev/tty
    printf '\tchsh -s $(which zsh) $(whoami)\n' 1>/dev/tty
    echo "W: Please restart after for default shell change to take effect." 1>/dev/tty
else
    apt-get -qq --yes install zsh
fi

apt-get -qq --yes install tmux
apt-get -qq --yes install ffmpeg
apt-get -qq --yes install gdebi-core
apt-get -qq --yes install tlp tlp-rdw
apt-get -qq --yes install numlockx
apt-get -qq --yes install pgformatter
apt-get -qq --yes install flac
apt-get -qq --yes install xboxdrv
apt-get -qq --yes install postgresql postgresql-contrib
apt-get -qq --yes install hwinfo
apt-get -qq --yes install rar
apt-get -qq --yes install clang-format


# GUI APPS
apt-get -qq --yes install cherrytree
apt-get -qq --yes install keepassxc
apt-get -qq --yes install crow-translate
apt-get -qq --yes install gsmartcontrol
apt-get -qq --yes install obs-studio
apt-get -qq --yes install openshot-qt python3-openshot
apt-get -qq --yes install picard
apt-get -qq --yes install qbittorrent
apt-get -qq --yes install steam
apt-get -qq --yes install tlpui
apt-get -qq --yes install gparted
apt-get -qq --yes install xournalpp
apt-get -qq --yes install quodlibet
apt-get -qq --yes install zathura
apt-get -qq --yes install thunderbird
apt-get -qq --yes install peek
apt-get -qq --yes install feh
apt-get -qq --yes install chromium
apt-get -qq --yes install gimp

# installing dependencies

#   pyenv
apt-get -qq --yes install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

#   alacritty
apt-get -qq --yes install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libegl1-mesa-dev

#   any_term_dropdown.sh
apt-get -qq --yes install coreutils xdotool
apt-get -qq --yes install libxcb-util-dev libxcb-cursor-dev

#   onedrive
apt-get -qq --yes install build-essential libcurl4-openssl-dev libsqlite3-dev \
pkg-config git curl libnotify-dev

# usbip
apt-get -qq --yes install linux-tools-generic

# PyQt5 
apt-get -qq --yes install libxcb-xinerama0

# PostgreSQL
apt-get -qq --yes libpq-dev

echo '> APT APPS INSTALL FINISHED <' 1>/dev/tty



echo '### GLOBAL SOFTWARE FINISHED ###' 1>/dev/tty

echo '### INSTALLING FONTS ###' 1>/dev/tty
# Install MesloLGS truetype font
if ! [ -d "/usr/share/fonts/truetype/MesloLGS" ]; then
    echo '# INSTALLING MESLOLGS #' 1>/dev/tty
    mkdir -p MesloLGS
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O MesloLGS/MesloLGS-Regular.ttf &>>$LOG_DIR/apt_install.log
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O MesloLGS/MesloLGS-Bold.ttf &>>$LOG_DIR/apt_install.log
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O MesloLGS/MesloLGS-Italic.ttf &>>$LOG_DIR/apt_install.log
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O MesloLGS/MesloLGS-BoldItalic.ttf &>$LOG_DIR/apt_install.log

    cp -rf MesloLGS /usr/share/fonts/truetype
    fc-cache -f -v
    echo '> MESLOLGS INSTALL FINISHED <' 1>/dev/tty
else
    echo 'W: MESLOLGS ALREADY INSTALLED' 1>/dev/tty
fi

echo '>>> FONT INSTALL FINISHED <<<' 1>/dev/tty

# go back to user's directory
popd >/dev/null
rm -rf $TEMP_DIR
