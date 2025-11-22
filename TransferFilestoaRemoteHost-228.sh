#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ace of Diamonds Card
ace_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ace of Diamonds                            |"
    echo "     |                   Securely Transfer Files to a Remote Host              |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides a lightweight interface to securely transfer files   |"
    echo "     |  between local and remote systems using SCP (Secure Copy Protocol).      |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Transfer a File to a Remote Host                                     |"
    echo "     |  2. Download a File from a Remote Host                                   |"
    echo "     |  3. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) transfer_to_remote ;;
        2) download_from_remote ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_diamonds_menu ;;
    esac
}

# Transfer a file to a remote host
transfer_to_remote() {
    clear
    echo -e "${CYAN}Transfer a File to a Remote Host${RESET}"
    read -p "Enter the local file path to transfer: " local_file
    read -p "Enter the remote username: " username
    read -p "Enter the remote host IP or domain: " host
    read -p "Enter the remote destination path: " remote_path

    if [[ -f "$local_file" ]]; then
        scp "$local_file" "$username@$host:$remote_path"
        if [[ $? -eq 0 ]]; then
            echo -e "${CYAN}File successfully transferred to $username@$host:$remote_path${RESET}"
        else
            echo -e "${CYAN}Error: Failed to transfer the file.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: File $local_file not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_diamonds_menu
}

# Download a file from a remote host
download_from_remote() {
    clear
    echo -e "${CYAN}Download a File from a Remote Host${RESET}"
    read -p "Enter the remote username: " username
    read -p "Enter the remote host IP or domain: " host
    read -p "Enter the remote file path to download: " remote_file
    read -p "Enter the local destination path: " local_path

    scp "$username@$host:$remote_file" "$local_path"
    if [[ $? -eq 0 ]]; then
        echo -e "${CYAN}File successfully downloaded to $local_path${RESET}"
    else
        echo -e "${CYAN}Error: Failed to download the file.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_diamonds_menu
}

ace_of_diamonds_menu
