#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the King of Diamonds Card
king_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              King of Diamonds                           |"
    echo "     |                       Securely Delete Sensitive Files                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card uses the shred utility to securely delete files, ensuring    |"
    echo "     |  that the data cannot be recovered.                                     |"
    echo "     |                                                                         |"
    echo "     |  1. Shred a File                                                        |"
    echo "     |  2. Shred a Directory                                                   |"
    echo "     |  3. Verify Shred Installation                                           |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) shred_file ;;
        2) shred_directory ;;
        3) verify_shred ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_diamonds_menu ;;
    esac
}

# Securely Shred a File
shred_file() {
    clear
    echo -e "${CYAN}Shredding a File...${RESET}"
    read -p "Enter the path of the file to shred: " filepath
    if [[ -f $filepath ]]; then
        read -p "Enter the number of overwrite passes (default is 3): " passes
        passes=${passes:-3}
        shred -u -n "$passes" "$filepath"
        echo -e "${CYAN}File securely deleted.${RESET}"
    else
        echo "Error: File not found at $filepath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# Securely Shred a Directory
shred_directory() {
    clear
    echo -e "${CYAN}Shredding a Directory...${RESET}"
    read -p "Enter the path of the directory to shred: " dirpath
    if [[ -d $dirpath ]]; then
        read -p "Enter the number of overwrite passes (default is 3): " passes
        passes=${passes:-3}
        find "$dirpath" -type f -exec shred -u -n "$passes" {} +
        echo -e "${CYAN}Directory contents securely deleted.${RESET}"
    else
        echo "Error: Directory not found at $dirpath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# Verify Shred Installation
verify_shred() {
    clear
    if command -v shred &>/dev/null; then
        echo -e "${CYAN}Shred is installed and ready to use.${RESET}"
    else
        echo -e "${CYAN}Error: Shred is not installed.${RESET}"
        echo "Please install it using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

king_of_diamonds_menu
