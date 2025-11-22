#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Clubs Card
seven_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Seven of Clubs                             |"
    echo "     |                   Evade Forensic Investigations Efficiently             |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools and techniques to securely erase data,        |"
    echo "     |  clear logs, and avoid forensic investigations.                         |"
    echo "     |                                                                         |"
    echo "     |  1. Securely Erase Files                                                |"
    echo "     |  2. Wipe Free Disk Space                                                |"
    echo "     |  3. Clear System Logs                                                   |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) securely_erase_files ;;
        2) wipe_free_disk_space ;;
        3) clear_system_logs ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_clubs_menu ;;
    esac
}

# Securely Erase Files
securely_erase_files() {
    clear
    echo -e "${CYAN}Securely Erasing Files...${RESET}"
    if command -v shred &>/dev/null; then
        echo "Enter the file path you want to securely erase:"
        read -p "File Path: " file_path
        if [[ -f "$file_path" ]]; then
            shred -u -n 5 "$file_path"
            echo "File securely erased."
        else
            echo "Error: File not found."
        fi
    else
        echo "Error: shred is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

# Wipe Free Disk Space
wipe_free_disk_space() {
    clear
    echo -e "${CYAN}Wiping Free Disk Space...${RESET}"
    if command -v dd &>/dev/null; then
        echo "Enter the directory where free space will be wiped (e.g., /):"
        read -p "Directory: " directory
        sudo dd if=/dev/zero of="$directory"/zero.fill bs=1M status=progress && sudo rm -f "$directory"/zero.fill
        echo "Free disk space wiped."
    else
        echo "Error: dd is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

# Clear System Logs
clear_system_logs() {
    clear
    echo -e "${CYAN}Clearing System Logs...${RESET}"
    if [[ $EUID -ne 0 ]]; then
        echo "This action requires root permissions. Please run as root."
    else
        find /var/log -type f -exec truncate -s 0 {} \;
        echo "System logs cleared."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

seven_of_clubs_menu
