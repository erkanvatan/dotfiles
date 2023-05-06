#! /usr/bin/env bash

# You must run `ssh-add` prior to running the script, otherwise it asks for passphrase for every operation.

REMOTE_IP=${1}
USER=${2}

if [ "$#" -ne 2 ]; then
    echo "E: Illegal number of parameters"
    echo "usage: bash $0 remote_ip username"
    exit 1
fi

ROOT_CONN="root@$REMOTE_IP" # root user conection string to use for ssh
USER_CONN="$USER@$REMOTE_IP" # normal user conection string to use for ssh
declare -A dirs # declare hash table for src and dest values

# CONFIG #

## Array of directories to mirror in the format ['source']='destination'
dirs=(
    ["$HOME/projects/rsync/sub1"]="~/project"
    ["$HOME/projects/rsync/no_root/"]="~/project/hello"
)
### Usage:
### dirs=(
#       ['./nginx/']='~/project/web_server'  # doesn't crate folder named "nginx"
#       ['./client']='~/project'             # creates root folder called "client"
### )

##########

echo '### MIRRORING DIRECTORIES ###'
for src in ${!dirs[@]} ; do
    rsync -Pate ssh "$src" "$USER_CONN:${dirs[$src]}" # mirror directories
done
echo '>>> MIRRORING DIRECTORIES FINISHED <<<'
