#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Diamonds Card
five_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Five of Diamonds                           |"
    echo "     |               Package Sensitive Data for Exfiltration                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to create secure archives of sensitive files      |"
    echo "     |  and prepare them for exfiltration or secure storage.                   |"
    echo "     |                                                                         |"
    echo "     |  1. Create a Secure Archive                                             |"
    echo "     |  2. Extract an Archive                                                  |"
    echo "     |  3. View Contents of an Archive                                         |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_archive ;;
        2) extract_archive ;;
        3) view_archive ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_diamonds_menu ;;
    esac
}

# Create a secure archive
create_archive() {
    clear
    echo -e "${CYAN}Creating a secure archive...${RESET}"
    read -p "Enter the directory or files to archive (space-separated): " files
    read -p "Enter the name for the archive file (e.g., archive.tar.gz): " archive_name
    read -sp "Enter a password to encrypt the archive: " password
    echo
    tar -czf - $files | openssl enc -aes-256-cbc -salt -out "$archive_name" -pass pass:"$password"
    echo -e "${CYAN}Archive $archive_name created and encrypted.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Extract an archive
extract_archive() {
    clear
    echo -e "${CYAN}Extracting an archive...${RESET}"
    read -p "Enter the archive file to extract: " archive_name
    read -sp "Enter the password for the archive: " password
    echo
    openssl enc -d -aes-256-cbc -in "$archive_name" -pass pass:"$password" | tar -xzf -
    echo -e "${CYAN}Archive $archive_name extracted.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# View contents of an archive
view_archive() {
    clear
    echo -e "${CYAN}Viewing contents of an archive...${RESET}"
    read -p "Enter the archive file to view: " archive_name
    read -sp "Enter the password for the archive: " password
    echo
    openssl enc -d -aes-256-cbc -in "$archive_name" -pass pass:"$password" | tar -tzf -
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

five_of_diamonds_menu
