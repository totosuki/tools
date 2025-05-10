#!/bin/bash

function runcmd() 
{
    local pwd_out="$(pwd)"
    echo -e "${pwd_out/#$HOME/~} $ $1"
    eval "$1"
}

# prepare
message="${@: -1}"

# add & status
if [ $# -eq 1 ]; then
    runcmd "git add -A"
else
    paths=("${@:1:$# -1}")
    runcmd "git add ${paths}"
fi
runcmd "git status -s"

# commit
echo -n "Do you want to commit? (y/n) "
read -r answer
if [ "${answer}" != "y" ]; then
    echo -n "Do you want to cancel staging? (y/n) "
    read -r answer
    if [ "${answer}" = "y" ]; then
        runcmd "$ git restore --staged \$(git rev-parse --show-toplevel)"
        echo "Staging cancelled."
    fi
    echo "Commit cancelled."
    return 0
fi
runcmd "git commit -m \"${message}\""

# push
echo -n "Do you want to push? (y/n) "
read -r answer
if [ "${answer}" = "y" ]; then
    runcmd "git push"
else
    echo "Push cancelled."
    return 0
fi