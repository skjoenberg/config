# Git functions
function gst
        git status
end

function ga
        git add $argv
end

function gd
        git diff $argv
end

function gc
        git commit $argv
end

function gp
        git push
end

function gpl
        git pull
end

# Add private key
function sl
        ssh-add /home/sebastian/.ssh/sebastian_priv.key
end

# Open pdf
function pdf
        mupdf $argv &
end

# TMUX
set ID eval 'tmux ls | grep -vm1 attached | cut -d: -f1'
if eval $ID
        tmux new-session
else
        tmux attach-session -t (ID)
end

# Clear the terminal
eval 'clear'
