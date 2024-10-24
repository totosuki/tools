#!/bin/bash

dir=$(find ~ -type d | fzf-tmux -p)
cd "$dir"
echo "Jump to $dir"