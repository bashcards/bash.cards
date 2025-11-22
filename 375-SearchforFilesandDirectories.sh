#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Queen of Spades Card
queen_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Queen of Spades                            |"
    echo "     |                      Search for Files and Directories                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to search for files and directories based on      |"
    echo "     |  various criteria, such as name, type, size, or modified time.          |"
    echo "     |                                                                         |"
    echo "     |  1. Search by name                                                      |"
    echo "     |  2. Search by type (file/directory)                                     |"
    echo "     |  3. Search by size                                                      |"
    echo "     |  4. Search by modified time                                             |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) search_by_name ;;
        2) search_by_type ;;
        3) search_by_size ;;
        4) search_by_time ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_spades_menu ;;
    esac
}

# Search by name
search_by_name() {
    clear
    echo -e "${CYAN}Search by Name${RESET}"
    read -p "Enter the file or directory name to search for: " name
    read -p "Enter the directory to search in (default: current directory): " dir
    dir=${dir:-.}

    if [[ -d $dir ]]; then
        echo -e "${GREEN}Searching for \"$name\" in \"$dir\"...${RESET}"
        find "$dir" -name "$name"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

# Search by type
search_by_type() {
    clear
    echo -e "${CYAN}Search by Type${RESET}"
    echo "Choose type to search for:"
    echo "1. Files"
    echo "2. Directories"
    read -p "Choice: " type_choice
    read -p "Enter the directory to search in (default: current directory): " dir
    dir=${dir:-.}

    case $type_choice in
        1) type="f" ;;
        2) type="d" ;;
        *) echo "Invalid choice. Returning to menu."; sleep 1; queen_of_spades_menu ;;
    esac

    if [[ -d $dir ]]; then
        echo -e "${GREEN}Searching for type \"$type\" in \"$dir\"...${RESET}"
        find "$dir" -type "$type"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

# Search by size
search_by_size() {
    clear
    echo -e "${CYAN}Search by Size${RESET}"
    read -p "Enter the size criteria (e.g., +1M, -500K): " size
    read -p "Enter the directory to search in (default: current directory): " dir
    dir=${dir:-.}

    if [[ -d $dir ]]; then
        echo -e "${GREEN}Searching for files matching size \"$size\" in \"$dir\"...${RESET}"
        find "$dir" -size "$size"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

# Search by modified time
search_by_time() {
    clear
    echo -e "${CYAN}Search by Modified Time${RESET}"
    read -p "Enter the time criteria (e.g., -1 for last 1 day, +7 for older than 7 days): " time
    read -p "Enter the directory to search in (default: current directory): " dir
    dir=${dir:-.}

    if [[ -d $dir ]]; then
        echo -e "${GREEN}Searching for files modified \"$time\" days ago in \"$dir\"...${RESET}"
        find "$dir" -mtime "$time"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_spades_menu
}

queen_of_spades_menu
