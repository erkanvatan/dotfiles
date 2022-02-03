#
# Executes commands at logout.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

SAYINGS=(
    "Good morning! And in case I don't see ya, good afternoon, good evening and goodnight.\n  --Truman Burbank"
)

# Print a randomly-chosen message:
echo $SAYINGS[$(($RANDOM % ${#SAYINGS} + 1))]

} >&2

# Remove ssh password when you logout
kill $SSH_AGENT_PID
