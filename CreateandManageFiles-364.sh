#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'

# Menu for the Ace of Spades Card
ace_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ace of Spades                              |"
    echo "     |                            Create and Manage Files                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a streamlined interface to create and manage files. |"
    echo "     |  Choose an option below to perform file-related tasks.                  |"
    echo "     |                                                                         |"
    echo "     |  1. Create an Empty File                                                |"
    echo "     |  2. View File Details                                                   |"
    echo "     |  3. Edit File Contents                                                  |"
    echo "     |  4. Delete a File                                                       |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_file ;;
        2) view_file_details ;;
        3) edit_file ;;
        4) delete_file ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_spades_menu ;;
    esac
}

# Option 1: Create an Empty File
create_file() {
    clear
    read -p "Enter the filename to create: " filename
    if [[ -z $filename ]]; then
        echo -e "${RED}Error: Filename cannot be empty.${RESET}"
    elif [[ -e $filename ]]; then
        echo -e "${RED}Error: File $filename already exists.${RESET}"
    else
        touch "$filename"
        echo -e "${GREEN}File $filename created successfully.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

# Option 2: View File Details
view_file_details() {
    clear
    read -p "Enter the filename to view details: " filename
    if [[ -e $filename ]]; then
        echo -e "${CYAN}Details of $filename:${RESET}"
        ls -l "$filename"
        echo -e "${CYAN}File Contents:${RESET}"
        cat "$filename"
    else
        echo -e "${RED}Error: File $filename does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

# Option 3: Edit File Contents
edit_file() {
    clear
    read -p "Enter the filename to edit: " filename
    if [[ -e $filename ]]; then
        echo -e "${CYAN}Opening $filename for editing...${RESET}"
        nano "$filename"
    else
        echo -e "${RED}Error: File $filename does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

# Option 4: Delete a File
delete_file() {
    clear
    read -p "Enter the filename to delete: " filename
    if [[ -e $filename ]]; then
        rm -i "$filename"
        echo -e "${GREEN}File $filename deleted successfully.${RESET}"
    else
        echo -e "${RED}Error: File $filename does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

ace_of_spades_menu
