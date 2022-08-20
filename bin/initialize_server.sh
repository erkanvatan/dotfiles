#! /usr/bin/env bash

REMOTE_IP=${1}
USER=${2}

if [ "$#" -ne 2 ]; then
    echo "E: Illegal number of parameters"
    echo "usage: bash $0 remote_ip username"
    exit 1
fi

ROOT_CONN="root@$REMOTE_IP" # root user conection string to use for ssh
USER_CONN="$USER@$REMOTE_IP" # normal user conection string to use for ssh
declare -A files # declare hash table for src and dest values

# CONFIG #

## Array of directories to create in the format ("dir1" "sub/dir2")
dirs=(
)

## Array of files to copy in the format ['source']='destination'
files=(
    ["$HOME/.bashrc"]="~/.bashrc"
    ["$HOME/.vimrc"]="~/.vimrc"
)
### Usage:
### files=(
#       ['./nginx/nginx.conf']='~/nginx/nginx.conf'  # single file
#       ['./nginx']='~'                        # directory
### )



##########
# remember the ssh passphrase
eval `ssh-agent` 
ssh-add

echo '### CREATING USER ###'
ssh $ROOT_CONN "sudo adduser $USER"
ssh $ROOT_CONN "sudo usermod -aG sudo $USER"

ssh $ROOT_CONN "mkdir -p /home/$USER/.ssh"
scp -r "$HOME/.ssh/id_rsa.pub" "$ROOT_CONN:/home/$USER/.ssh/authorized_keys" # copy files

ssh $ROOT_CONN "sudo groupadd docker"
ssh $ROOT_CONN "sudo usermod -aG docker $USER"
echo '>>> CREATING USER FINISHED <<<'

echo '### SETTING UFW ###'
ssh $ROOT_CONN << 'EOF'
sudo ufw allow 80
sudo ufw allow 22
sudo ufw --force enable
EOF
echo '>>> SETTING UFW FINISHED <<<'

echo '### CREATING DIRECTORIES ###'
for dir in ${dirs} ; do
    ssh $USER_CONN "mkdir -p ${dir}" # create directories if they do not exist
done
echo '>>> CREATING DIRECTORIES FINISHED <<<'

echo '### COPYING FILES ###'
for src in ${!files[@]} ; do
    rsync -Pravdtze ssh "$src" "$USER_CONN:${files[$src]}" # copy files
done
echo '>>> COPYING FILES FINISHED <<<'


echo '### INSTALLING PROGRAMS ###'
# Uninstall old packages

# apt-get -qq --yes remove docker docker-engine docker.io containerd runc

echo '# Docker #'
ssh $ROOT_CONN << 'EOF'
    sudo apt-get -y remove docker docker-engine docker.io containerd runc # Uninstall old versions
    sudo apt-get -y update
    sudo apt-get -y install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get -y update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo apt-get -y install haveged
    sudo apt-get -y install mosh
    sudo ufw allow mosh
    sudo apt-get -y install net-utils
EOF
echo '>>> INSTALLING PROGRAMS FINISHED <<<'

kill $SSH_AGENT_PID # kill ssh-agent
