#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to recover lost partitions with testdisk
recover_partitions() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                Four of Diamonds: Partition Recovery Tool                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | TestDisk is a powerful tool for recovering lost partitions and repairing  |"
    echo "    | broken file systems. Select an option to proceed:                         |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Launch TestDisk for advanced recovery                                 |"
    echo "    |  2. Scan for lost partitions on a specific disk                           |"
    echo "    |  3. Analyze a specific disk for recovery options                          |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Launching TestDisk... Follow the interactive prompts."
            sudo testdisk
            ;;
        2)
            echo "Available disks:"
            lsblk -d -o NAME,SIZE,MODEL
            read -p "Enter the disk name (e.g., sda): " disk_name
            echo "Scanning $disk_name for lost partitions..."
            sudo testdisk /dev/$disk_name
            ;;
        3)
            echo "Available disks:"
            lsblk -d -o NAME,SIZE,MODEL
            read -p "Enter the disk name (e.g., sda): " disk_name
            echo "Analyzing $disk_name for recovery options..."
            sudo testdisk /dev/$disk_name
            ;;
        4)
            echo "Exiting Partition Recovery Tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure testdisk is installed
if ! command -v testdisk &> /dev/null; then
    echo "TestDisk is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y testdisk
fi

# Main script execution
recover_partitions
clear
