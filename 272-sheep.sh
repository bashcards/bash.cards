#!/bin/bash

while true; do
    clear
    echo "Select a directory:"
    select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
    cd "$d" || exit
done
