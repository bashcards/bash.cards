#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Diamonds Card
queen_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                             Queen of Diamonds                           |"
    echo "     |                       Securely Encrypt Sensitive Data                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card utilizes GPG to encrypt, decrypt, and manage sensitive data. |"
    echo "     |                                                                         |"
    echo "     |  1. Encrypt a File                                                      |"
    echo "     |  2. Decrypt a File                                                      |"
    echo "     |  3. Generate a New GPG Key Pair                                         |"
    echo "     |  4. List Existing GPG Keys                                              |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) encrypt_with_gpg ;;
        2) decrypt_with_gpg ;;
        3) generate_gpg_key ;;
        4) list_gpg_keys ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_diamonds_menu ;;
    esac
}

# Encrypt a File
encrypt_with_gpg() {
    clear
    echo -e "${CYAN}Encrypting a File...${RESET}"
    read -p "Enter the file path to encrypt: " filepath
    if [[ -f $filepath ]]; then
        read -p "Enter the recipient's GPG key email: " recipient
        gpg --encrypt --recipient "$recipient" "$filepath"
        echo -e "${CYAN}File encrypted successfully.${RESET}"
    else
        echo "Error: File not found at $filepath."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Decrypt a File
decrypt_with_gpg() {
    clear
    echo -e "${CYAN}Decrypting a File...${RESET}"
    read -p "Enter the path of the encrypted file: " encrypted_file
    if [[ -f $encrypted_file ]]; then
        gpg --decrypt "$encrypted_file"
        echo -e "${CYAN}File decrypted successfully.${RESET}"
    else
        echo "Error: Encrypted file not found at $encrypted_file."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Generate a New GPG Key Pair
generate_gpg_key() {
    clear
    echo -e "${CYAN}Generating a New GPG Key Pair...${RESET}"
    gpg --full-generate-key
    echo -e "${CYAN}GPG key pair created successfully.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# List Existing GPG Keys
list_gpg_keys() {
    clear
    echo -e "${CYAN}Listing Existing GPG Keys...${RESET}"
    gpg --list-keys
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

queen_of_diamonds_menu
