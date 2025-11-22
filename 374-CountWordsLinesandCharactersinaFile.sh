#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Jack of Spades Card
jack_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                               Jack of Spades                            |"
    echo "     |                   Count Words, Lines, and Characters in a File          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to quickly analyze a file by counting the         |"
    echo "     |  number of lines, words, characters, or bytes it contains.              |"
    echo "     |                                                                         |"
    echo "     |  1. Count all details (lines, words, and characters)                    |"
    echo "     |  2. Count only lines                                                    |"
    echo "     |  3. Count only words                                                    |"
    echo "     |  4. Count only characters                                               |"
    echo "     |  5. Count file size in bytes                                            |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) count_all ;;
        2) count_lines ;;
        3) count_words ;;
        4) count_characters ;;
        5) count_file_size ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_spades_menu ;;
    esac
}

# Count all details
count_all() {
    clear
    echo -e "${CYAN}Count All Details${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Counting lines, words, and characters for $file_path:${RESET}"
        wc "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Count lines
count_lines() {
    clear
    echo -e "${CYAN}Count Lines${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Line count for $file_path:${RESET}"
        wc -l "$file_path" | awk '{print $1 " lines"}'
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Count words
count_words() {
    clear
    echo -e "${CYAN}Count Words${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Word count for $file_path:${RESET}"
        wc -w "$file_path" | awk '{print $1 " words"}'
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Count characters
count_characters() {
    clear
    echo -e "${CYAN}Count Characters${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}Character count for $file_path:${RESET}"
        wc -m "$file_path" | awk '{print $1 " characters"}'
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Count file size in bytes
count_file_size() {
    clear
    echo -e "${CYAN}Count File Size${RESET}"
    read -p "Enter the file path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}File size in bytes for $file_path:${RESET}"
        wc -c "$file_path" | awk '{print $1 " bytes"}'
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

jack_of_spades_menu
