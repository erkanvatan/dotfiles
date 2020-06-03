# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ls="ls --color"

# Powerline (displays current directory colored)
#if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
#   source /usr/share/powerline/bindings/bash/powerline.sh
#fi

# Full Path Current Directory 
export PS1="\[\033[1;32m\]\u \[\033[31m\]\W $ \[\033[0m\]"

# Terminal First Open

echo -e "Welcome ${USER}"
echo " "
date "+%A %d %B %Y, %T"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
echo " "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
