#!/bin/bash

# TUI interface
tput clear
tput cup 3 15
tput setaf 3
echo "Welcome to the system"
tput sgr0
tput cup 5 17
tput setaf 7
echo "User Info:"
tput sgr0
tput cup 7 15
tput setaf 4
echo "Username: $(whoami)"
tput sgr0
tput cup 9 15
tput setaf 5
echo "Date/Time: $(date)"
tput sgr0
tput cup 11 15
tput setaf 6
echo "System Info:"
tput sgr0
tput cup 13 15
tput setaf 7
echo "OS: $(uname -s)"
tput sgr0
tput cup 15 15
tput setaf 2
echo "Kernel Version: $(uname -r)"
tput sgr0
tput cup 17 15
tput setaf 3
echo "Architecture: $(uname -m)"
tput sgr0
tput cup 20 0
echo -e "Press any key to exit \c"
read input
tput clear
tput sgr0
tput rc
