#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Nine of Spades Card
nine_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                               Nine of Spades                            |"
    echo "     |                   View the First Few Lines of a File                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to view the top lines of a file with options to   |"
    echo "     |  customize the number of lines displayed, view file details, and more.  |"
    echo "     |                                                                         |"
    echo "     |  1. View the default top 10 lines                                       |"
    echo "     |  2. Customize the number of lines to display                            |"
    echo "     |  3. Display file metadata                                               |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_top_lines 10 ;;
        2) customize_top_lines ;;
        3) display_file_metadata ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_spades_menu ;;
    esac
}

# View the top n lines of a file
view_top_lines() {
    local lines=$1
    clear
    echo -e "${CYAN}View the First $lines Lines of a File${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Displaying the first $lines lines of $file_path:${RESET}"
        head -n "$lines" "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_spades_menu
}

# Customize the number of lines to display
customize_top_lines() {
    clear
    echo -e "${CYAN}Customize the Number of Lines to Display${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        read -p "Enter the number of lines to display: " num_lines
        if [[ $num_lines =~ ^[0-9]+$ && $num_lines -gt 0 ]]; then
            view_top_lines "$num_lines"
        else
            echo -e "${RED}Error: Please enter a valid positive number.${RESET}"
            sleep 1
            customize_top_lines
        fi
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi
}

# Display file metadata
display_file_metadata() {
    clear
    echo -e "${CYAN}Display File Metadata${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Displaying metadata for $file_path:${RESET}"
        echo "File Size: $(stat -c%s "$file_path") bytes"
        echo "Last Modified: $(stat -c%y "$file_path")"
        echo "File Owner: $(stat -c%U "$file_path")"
        echo "Permissions: $(stat -c%A "$file_path")"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_spades_menu
}

nine_of_spades_menu
