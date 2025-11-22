#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Diamonds Card
jack_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                             Jack of Diamonds                            |"
    echo "     |                        Encrypt Files for Transfer                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card uses zip with encryption to secure files before transfer.    |"
    echo "     |                                                                         |"
    echo "     |  1. Encrypt a File                                                      |"
    echo "     |  2. Decrypt an Encrypted File                                           |"
    echo "     |  3. Verify the Encrypted File                                           |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) encrypt_file ;;
        2) decrypt_file ;;
        3) verify_encrypted_file ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_diamonds_menu ;;
    esac
}

# Encrypt a File
encrypt_file() {
    clear
    echo -e "${CYAN}Encrypting a File...${RESET}"
    read -p "Enter the file path to encrypt: " filepath
    if [[ -f $filepath ]]; then
        read -p "Enter a name for the encrypted file (e.g., secure.zip): " zipname
        echo "Encrypting $filepath..."
        zip -e "$zipname" "$filepath"
        echo -e "${CYAN}File encrypted as $zipname.${RESET}"
    else
        echo "Error: File not found at $filepath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Decrypt an Encrypted File
decrypt_file() {
    clear
    echo -e "${CYAN}Decrypting an Encrypted File...${RESET}"
    read -p "Enter the path of the encrypted zip file: " zippath
    if [[ -f $zippath ]]; then
        echo "Decrypting $zippath..."
        unzip "$zippath"
    else
        echo "Error: Encrypted file not found at $zippath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Verify the Encrypted File
verify_encrypted_file() {
    clear
    echo -e "${CYAN}Verifying the Encrypted File...${RESET}"
    read -p "Enter the path of the encrypted zip file: " zippath
    if [[ -f $zippath ]]; then
        if zip -T "$zippath"; then
            echo -e "${CYAN}The encrypted file $zippath is valid.${RESET}"
        else
            echo "The encrypted file $zippath is corrupted."
        fi
    else
        echo "Error: File not found at $zippath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

jack_of_diamonds_menu
