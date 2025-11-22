#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to restore system from backups
restore_backup() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                          Two of Diamonds: System Restore                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool allows you to restore your system from existing backup files.   |"
    echo "    | Select a backup to restore:                                               |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Restore full system backup (/root/system_backup.tar.gz)               |"
    echo "    |  2. Restore home directory backup (/root/home_backup.tar.gz)              |"
    echo "    |  3. Restore custom directory from backup                                  |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            if [ -f /root/system_backup.tar.gz ]; then
                echo "Restoring full system backup..."
                sudo tar -xzvf /root/system_backup.tar.gz -C /
                echo "System restore completed."
            else
                echo "Full system backup not found at /root/system_backup.tar.gz."
            fi
            ;;
        2)
            if [ -f /root/home_backup.tar.gz ]; then
                echo "Restoring home directory backup..."
                sudo tar -xzvf /root/home_backup.tar.gz -C /
                echo "Home directory restore completed."
            else
                echo "Home directory backup not found at /root/home_backup.tar.gz."
            fi
            ;;
        3)
            read -p "Enter the backup file path (e.g., /root/backup_name.tar.gz): " backup_path
            if [ -f "$backup_path" ]; then
                read -p "Enter the target directory to restore: " target_directory
                echo "Restoring backup from $backup_path to $target_directory..."
                sudo tar -xzvf "$backup_path" -C "$target_directory"
                echo "Custom restore completed."
            else
                echo "Backup file $backup_path not found."
            fi
            ;;
        4)
            echo "Exiting restore tool."
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
restore_backup
clear
