#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'

# Menu for the Two of Spades Card
two_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Two of Spades                              |"
    echo "     |                            Create and Manage Directories                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a streamlined interface to create and manage        |"
    echo "     |  directories. Choose an option below to perform directory-related tasks.|"
    echo "     |                                                                         |"
    echo "     |  1. Create a New Directory                                              |"
    echo "     |  2. List Contents of a Directory                                        |"
    echo "     |  3. Rename a Directory                                                  |"
    echo "     |  4. Delete a Directory                                                  |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_directory ;;
        2) list_directory_contents ;;
        3) rename_directory ;;
        4) delete_directory ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; two_of_spades_menu ;;
    esac
}

# Option 1: Create a New Directory
create_directory() {
    clear
    read -p "Enter the name of the directory to create: " dirname
    if [[ -z $dirname ]]; then
        echo -e "${RED}Error: Directory name cannot be empty.${RESET}"
    elif [[ -d $dirname ]]; then
        echo -e "${RED}Error: Directory $dirname already exists.${RESET}"
    else
        mkdir -p "$dirname"
        echo -e "${GREEN}Directory $dirname created successfully.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_spades_menu
}

# Option 2: List Contents of a Directory
list_directory_contents() {
    clear
    read -p "Enter the name of the directory to list contents: " dirname
    if [[ -d $dirname ]]; then
        echo -e "${CYAN}Contents of $dirname:${RESET}"
        ls -lh "$dirname"
    else
        echo -e "${RED}Error: Directory $dirname does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_spades_menu
}

# Option 3: Rename a Directory
rename_directory() {
    clear
    read -p "Enter the current name of the directory: " oldname
    if [[ -d $oldname ]]; then
        read -p "Enter the new name for the directory: " newname
        if [[ -z $newname ]]; then
            echo -e "${RED}Error: New directory name cannot be empty.${RESET}"
        elif [[ -d $newname ]]; then
            echo -e "${RED}Error: Directory $newname already exists.${RESET}"
        else
            mv "$oldname" "$newname"
            echo -e "${GREEN}Directory renamed from $oldname to $newname.${RESET}"
        fi
    else
        echo -e "${RED}Error: Directory $oldname does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_spades_menu
}

# Option 4: Delete a Directory
delete_directory() {
    clear
    read -p "Enter the name of the directory to delete: " dirname
    if [[ -d $dirname ]]; then
        rm -ri "$dirname"
        echo -e "${GREEN}Directory $dirname deleted successfully.${RESET}"
    else
        echo -e "${RED}Error: Directory $dirname does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_spades_menu
}

two_of_spades_menu
