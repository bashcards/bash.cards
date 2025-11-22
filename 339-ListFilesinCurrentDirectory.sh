#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Two of Hearts Card
two_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Two of Hearts                              |"
    echo "     |                      List Files in the Current Directory                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides options to list files and directories in various    |"
    echo "     |  formats and sort orders. It also includes filtering and quick actions. |"
    echo "     |                                                                         |"
    echo "     |  1. List All Files and Directories                                      |"
    echo "     |  2. List Only Files                                                     |"
    echo "     |  3. List Only Directories                                               |"
    echo "     |  4. Sort Files by Size                                                  |"
    echo "     |  5. Show Hidden Files                                                   |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_all ;;
        2) list_files ;;
        3) list_directories ;;
        4) sort_by_size ;;
        5) show_hidden ;;
        6) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; two_of_hearts_menu ;;
    esac
}

# List all files and directories
list_all() {
    clear
    echo -e "${CYAN}All Files and Directories:${RESET}"
    ls -lh --color=auto
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# List only files
list_files() {
    clear
    echo -e "${CYAN}Only Files:${RESET}"
    find . -type f -exec ls -lh --color=auto {} +
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# List only directories
list_directories() {
    clear
    echo -e "${CYAN}Only Directories:${RESET}"
    find . -type d -exec ls -ldh --color=auto {} +
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# Sort files by size
sort_by_size() {
    clear
    echo -e "${CYAN}Files Sorted by Size:${RESET}"
    ls -lhS --color=auto
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

# Show hidden files
show_hidden() {
    clear
    echo -e "${CYAN}Hidden Files and Directories:${RESET}"
    ls -lha --color=auto
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_hearts_menu
}

two_of_hearts_menu
