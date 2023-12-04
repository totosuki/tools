#!/bin/sh
path= pwd
echo '# commandsのalias' >> ~/.zshrc
echo "alias mkcd="source ${path}/commands/mkcd.sh"" >> ~/.zshrc