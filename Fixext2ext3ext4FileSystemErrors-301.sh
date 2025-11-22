#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to check and repair ext2/ext3/ext4 file systems
fix_ext_filesystem() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |       Eight of Diamonds: Fix ext2/ext3/ext4 File System Errors            |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | 'e2fsck' is a tool specifically designed for ext2/ext3/ext4 file systems. |"
    echo "    | It is used to detect and repair file system inconsistencies.              |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Check a specific partition for errors                                 |"
    echo "    |  2. Repair a specific partition                                           |"
    echo "    |  3. Show file system details                                              |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Checking a partition for errors..."
            read -p "Enter the partition to check (e.g., /dev/sda1): " partition
            if [[ -n $partition ]]; then
                echo "Running 'e2fsck -n' on $partition..."
                sudo e2fsck -n "$partition"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        2)
            echo "Repairing a partition..."
            read -p "Enter the partition to repair (e.g., /dev/sda1): " partition
            if [[ -n $partition ]]; then
                echo "Running 'e2fsck -y' on $partition..."
                sudo e2fsck -y "$partition"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        3)
            echo "Showing file system details..."
            read -p "Enter the partition (e.g., /dev/sda1): " partition
            if [[ -n $partition ]]; then
                echo "Running 'dumpe2fs' on $partition..."
                sudo dumpe2fs "$partition"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        4)
            echo "Exiting e2fsck tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure e2fsck is available
if ! command -v e2fsck &> /dev/null; then
    echo "Error: 'e2fsck' is not available on this system. Exiting..."
    exit 1
fi

# Main script execution
fix_ext_filesystem
clear
