#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "usage: mkcd <directory>"
    return 1
fi

mkdir -p "$1" && cd $1
