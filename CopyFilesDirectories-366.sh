#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'

# Menu for the Three of Spades Card
three_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Three of Spades                            |"
    echo "     |                           Copy Files/Directories                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an interactive interface to copy files or           |"
    echo "     |  directories from one location to another.                              |"
    echo "     |                                                                         |"
    echo "     |  1. Copy a File                                                         |"
    echo "     |  2. Copy a Directory                                                    |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) copy_file ;;
        2) copy_directory ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_spades_menu ;;
    esac
}

# Option 1: Copy a File
copy_file() {
    clear
    read -p "Enter the source file path: " src
    if [[ -f $src ]]; then
        read -p "Enter the destination path: " dest
        if cp "$src" "$dest"; then
            echo -e "${GREEN}File copied successfully to $dest.${RESET}"
        else
            echo -e "${RED}Error: Failed to copy the file.${RESET}"
        fi
    else
        echo -e "${RED}Error: Source file $src does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_spades_menu
}

# Option 2: Copy a Directory
copy_directory() {
    clear
    read -p "Enter the source directory path: " src
    if [[ -d $src ]]; then
        read -p "Enter the destination path: " dest
        if cp -r "$src" "$dest"; then
            echo -e "${GREEN}Directory copied successfully to $dest.${RESET}"
        else
            echo -e "${RED}Error: Failed to copy the directory.${RESET}"
        fi
    else
        echo -e "${RED}Error: Source directory $src does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_spades_menu
}

three_of_spades_menu
