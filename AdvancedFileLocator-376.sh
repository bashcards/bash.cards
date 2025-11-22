#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the King of Spades Card
king_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              King of Spades                             |"
    echo "     |                          Advanced File Locator                          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card leverages 'locate', 'find', and advanced utilities to        |"
    echo "     |  quickly and effectively locate files and directories.                  |"
    echo "     |                                                                         |"
    echo "     |  1. Search for a file or directory                                      |"
    echo "     |  2. Search by file size                                                 |"
    echo "     |  3. Search by modification time                                         |"
    echo "     |  4. Update file database                                                |"
    echo "     |  5. View recently accessed files                                        |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) search_file ;;
        2) search_by_size ;;
        3) search_by_mod_time ;;
        4) update_database ;;
        5) view_recent_access ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_spades_menu ;;
    esac
}

# Search for a file or directory
search_file() {
    clear
    echo -e "${CYAN}Search for a File or Directory${RESET}"
    read -p "Enter the file name or pattern to search for: " file_name

    if command -v locate &>/dev/null; then
        echo -e "${GREEN}Searching for \"$file_name\" using locate...${RESET}"
        results=$(locate "$file_name")
        if [[ -n $results ]]; then
            echo -e "${GREEN}Search results:${RESET}"
            echo "$results"
        else
            echo -e "${RED}No files matching \"$file_name\" were found.${RESET}"
        fi
    else
        echo -e "${RED}Error: 'locate' command is not installed.${RESET}"
        echo "Please install it using your package manager (e.g., apt, yum)."
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_spades_menu
}

# Search files by size
search_by_size() {
    clear
    echo -e "${CYAN}Search by File Size${RESET}"
    read -p "Enter minimum size (e.g., 10M, 1G): " min_size
    read -p "Enter maximum size (e.g., 100M, 2G): " max_size

    echo -e "${GREEN}Searching for files between $min_size and $max_size...${RESET}"
    find / -type f -size +"$min_size" -size -"$max_size" 2>/dev/null | sort
    echo -e "${GREEN}Search completed.${RESET}"

    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_spades_menu
}

# Search files by modification time
search_by_mod_time() {
    clear
    echo -e "${CYAN}Search by Modification Time${RESET}"
    read -p "Enter number of days (e.g., -7 for last 7 days, +30 for older than 30 days): " days

    echo -e "${GREEN}Searching for files modified $days days ago...${RESET}"
    find / -type f -mtime "$days" 2>/dev/null | sort
    echo -e "${GREEN}Search completed.${RESET}"

    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_spades_menu
}

# Update the file database
update_database() {
    clear
    echo -e "${CYAN}Updating File Database${RESET}"

    if command -v updatedb &>/dev/null; then
        echo -e "${GREEN}Updating the file database. This might take a while...${RESET}"
        sudo updatedb
        echo -e "${GREEN}File database updated successfully.${RESET}"
    else
        echo -e "${RED}Error: 'updatedb' command is not installed.${RESET}"
        echo "Please install it using your package manager (e.g., apt, yum)."
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_spades_menu
}

# View recently accessed files
view_recent_access() {
    clear
    echo -e "${CYAN}View Recently Accessed Files${RESET}"

    echo -e "${GREEN}Listing recently accessed files...${RESET}"
    find / -type f -atime -1 2>/dev/null | sort
    echo -e "${GREEN}Search completed.${RESET}"

    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_spades_menu
}

king_of_spades_menu
