#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to check and repair file systems
check_repair_filesystem() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |              Seven of Diamonds: Check and Repair File Systems             |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | 'fsck' is a tool used to check and repair file systems for errors.        |"
    echo "    | Please ensure all file systems to be repaired are unmounted.              |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Check a specific partition for errors                                 |"
    echo "    |  2. Repair a specific partition                                           |"
    echo "    |  3. List all partitions                                                   |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Checking a partition for errors..."
            read -p "Enter the partition to check (e.g., /dev/sda1): " partition
            if [[ -n $partition ]]; then
                echo "Running 'fsck -n' on $partition..."
                sudo fsck -n "$partition"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        2)
            echo "Repairing a partition..."
            read -p "Enter the partition to repair (e.g., /dev/sda1): " partition
            if [[ -n $partition ]]; then
                echo "Running 'fsck -y' on $partition..."
                sudo fsck -y "$partition"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        3)
            echo "Listing all partitions..."
            sudo lsblk -f
            ;;
        4)
            echo "Exiting File System Check tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure fsck is available
if ! command -v fsck &> /dev/null; then
    echo "Error: 'fsck' is not available on this system. Exiting..."
    exit 1
fi

# Main script execution
check_repair_filesystem
clear
