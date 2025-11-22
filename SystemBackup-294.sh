#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to automate system backups
automate_backup() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                          Ace of Diamonds: System Backup                   |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool automates  backups with options for different backup types.     |"
    echo "    | Select an option to proceed:                                              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Full system backup (/root/system_backup.tar.gz)                       |"
    echo "    |  2. Home directory backup (/root/home_backup.tar.gz)                      |"
    echo "    |  3. Custom directory backup                                               |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Creating full system backup..."
            sudo tar -czvf /root/system_backup.tar.gz --exclude=/root/system_backup.tar.gz --exclude=/proc --exclude=/tmp --exclude=/mnt --exclude=/dev --exclude=/sys /
            echo "Full system backup completed: /root/system_backup.tar.gz"
            ;;
        2)
            echo "Creating home directory backup..."
            sudo tar -czvf /root/home_backup.tar.gz /home
            echo "Home directory backup completed: /root/home_backup.tar.gz"
            ;;
        3)
            read -p "Enter the directory to backup: " directory
            if [ -d "$directory" ]; then
                backup_name=$(basename "$directory")
                echo "Creating backup for $directory..."
                sudo tar -czvf /root/"${backup_name}_backup.tar.gz" "$directory"
                echo "Backup completed: /root/${backup_name}_backup.tar.gz"
            else
                echo "Directory $directory does not exist."
            fi
            ;;
        4)
            echo "Exiting backup tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Main script execution
automate_backup
clear
