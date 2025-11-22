#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Ace of Hearts Card
ace_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ace of Hearts                              |"
    echo "     |                        Show the Current Directory                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides options to view, explore, and manage the current    |"
    echo "     |  working directory and its contents.                                    |"
    echo "     |                                                                         |"
    echo "     |  1. Show Current Directory                                              |"
    echo "     |  2. List Contents                                                       |"
    echo "     |  3. Search for a File/Folder                                            |"
    echo "     |  4. View Disk Usage in Current Directory                                |"
    echo "     |  5. Create a New Directory                                              |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) show_current_directory ;;
        2) list_contents ;;
        3) search_file_or_folder ;;
        4) view_disk_usage ;;
        5) create_directory ;;
        6) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; ace_of_hearts_menu ;;
    esac
}

# Show the current directory
show_current_directory() {
    clear
    echo -e "${CYAN}Current Directory:${RESET}"
    pwd
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# List contents of the current directory
list_contents() {
    clear
    echo -e "${CYAN}Contents of the Current Directory:${RESET}"
    ls -lh --color=auto
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# Search for a file or folder in the current directory
search_file_or_folder() {
    clear
    echo -e "${CYAN}Search for a File or Folder:${RESET}"
    read -p "Enter the name to search: " search_term
    echo -e "${GREEN}Searching...${RESET}"
    find . -iname "*$search_term*" 2>/dev/null | grep --color=always "$search_term" || echo -e "${RED}No results found.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# View disk usage in the current directory
view_disk_usage() {
    clear
    echo -e "${CYAN}Disk Usage in the Current Directory:${RESET}"
    du -sh ./*
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# Create a new directory
create_directory() {
    clear
    echo -e "${CYAN}Create a New Directory:${RESET}"
    read -p "Enter the name of the new directory: " dir_name
    if [[ -z "$dir_name" ]]; then
        echo -e "${RED}Directory name cannot be empty.${RESET}"
    elif [[ -d "$dir_name" ]]; then
        echo -e "${RED}Directory '$dir_name' already exists.${RESET}"
    else
        mkdir "$dir_name" && echo -e "${GREEN}Directory '$dir_name' created successfully.${RESET}" || echo -e "${RED}Failed to create directory.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

ace_of_hearts_menu
