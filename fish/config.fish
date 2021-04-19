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
        ssh-add /home/sebastian/.ssh/id_rsa
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

set PATH $PATH ~/.local/bin ~/.jdks/corretto-1.8.0_275/bin ~/.jdks/corretto-1.8.0_275

#alias java "~/.jdks/corretto-1.8.0_275/bin/java"

alias wip "git add . && git commit --no-verify -m \"wip\""

alias g "git"

alias mk "microk8s.kubectl"
alias mhelm "microk8s.helm3"
alias k "kubectl"

function cd
	builtin cd "$argv"
	ls
end

