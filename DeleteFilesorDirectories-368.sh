#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Five of Spades Card
five_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Five of Spades                             |"
    echo "     |                          Delete Files or Directories                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a secure and interactive way to delete files        |"
    echo "     |  and directories while ensuring safety and recovery options.            |"
    echo "     |                                                                         |"
    echo "     |  1. Delete a file                                                      |"
    echo "     |  2. Delete a directory                                                 |"
    echo "     |  3. View trash bin                                                     |"
    echo "     |  4. Restore a file from trash bin                                      |"
    echo "     |  5. Empty trash bin                                                    |"
    echo "     |  6. Exit                                                               |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) delete_file ;;
        2) delete_directory ;;
        3) view_trash_bin ;;
        4) restore_file ;;
        5) empty_trash_bin ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_spades_menu ;;
    esac
}

# Function to delete a file
delete_file() {
    clear
    echo -e "${CYAN}Delete a File${RESET}"
    read -p "Enter the file path to delete: " file_path

    if [[ -f $file_path ]]; then
        mv "$file_path" ~/.trash/
        echo -e "${GREEN}File moved to trash bin: $file_path${RESET}"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Function to delete a directory
delete_directory() {
    clear
    echo -e "${CYAN}Delete a Directory${RESET}"
    read -p "Enter the directory path to delete: " dir_path

    if [[ -d $dir_path ]]; then
        mv "$dir_path" ~/.trash/
        echo -e "${GREEN}Directory moved to trash bin: $dir_path${RESET}"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Function to view the trash bin
view_trash_bin() {
    clear
    echo -e "${CYAN}Trash Bin Contents${RESET}"
    ls -lh ~/.trash/
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Function to restore a file or directory from the trash bin
restore_file() {
    clear
    echo -e "${CYAN}Restore a File or Directory from Trash Bin${RESET}"
    read -p "Enter the name of the file or directory to restore: " item_name

    if [[ -e ~/.trash/$item_name ]]; then
        mv ~/.trash/$item_name ./
        echo -e "${GREEN}Restored: $item_name${RESET}"
    else
        echo -e "${RED}Error: Item not found in trash bin.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Function to empty the trash bin
empty_trash_bin() {
    clear
    echo -e "${YELLOW}Emptying Trash Bin...${RESET}"
    rm -rf ~/.trash/*
    echo -e "${GREEN}Trash bin emptied.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_spades_menu
}

# Ensure trash bin directory exists
mkdir -p ~/.trash

five_of_spades_menu
