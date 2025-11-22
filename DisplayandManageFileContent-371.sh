#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Eight of Spades Card
eight_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Eight of Spades                            |"
    echo "     |                   Display and Manage File Contents                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to view the contents of a file, search within     |"
    echo "     |  the file, and even paginate through large files.                       |"
    echo "     |                                                                         |"
    echo "     |  1. View the full content of a file                                     |"
    echo "     |  2. Search for a specific string in a file                              |"
    echo "     |  3. Paginate through a large file                                       |"
    echo "     |  4. Display line numbers with content                                   |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_full_content ;;
        2) search_in_file ;;
        3) paginate_file ;;
        4) display_with_line_numbers ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_spades_menu ;;
    esac
}

# View the full content of a file
view_full_content() {
    clear
    echo -e "${CYAN}View Full Content of a File${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Displaying the content of $file_path:${RESET}"
        cat "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

# Search for a specific string in a file
search_in_file() {
    clear
    echo -e "${CYAN}Search for a String in a File${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        read -p "Enter the string to search for: " search_string
        echo -e "${GREEN}Searching for '$search_string' in $file_path:${RESET}"
        grep --color=always -n "$search_string" "$file_path" || echo -e "${RED}No matches found.${RESET}"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

# Paginate through a large file
paginate_file() {
    clear
    echo -e "${CYAN}Paginate Through a File${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        less "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

# Display file content with line numbers
display_with_line_numbers() {
    clear
    echo -e "${CYAN}Display File Content with Line Numbers${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Displaying the content of $file_path with line numbers:${RESET}"
        nl "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

eight_of_spades_menu
