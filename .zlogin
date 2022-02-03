#
# Executes commands at login post-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

### user commands
# start onedrive sync
# $HOME/bin/onedrive_sync.sh


### prezto commands
# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then

fi >&2
