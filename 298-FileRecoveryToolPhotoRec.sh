#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to recover files with PhotoRec
recover_files() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |              Five of Diamonds: File Recovery Tool (PhotoRec)              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | PhotoRec is designed to recover files from damaged or formatted storage.  |"
    echo "    | Select an option below to proceed:                                        |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Launch PhotoRec for full recovery                                     |"
    echo "    |  2. Recover files from a specific disk                                    |"
    echo "    |  3. Recover files from a specific partition                               |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Launching PhotoRec... Follow the interactive prompts."
            sudo photorec
            ;;
        2)
            echo "Available disks:"
            lsblk -d -o NAME,SIZE,MODEL
            read -p "Enter the disk name (e.g., sda): " disk_name
            echo "Recovering files from $disk_name..."
            sudo photorec /dev/$disk_name
            ;;
        3)
            echo "Available partitions:"
            lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT
            read -p "Enter the partition name (e.g., sda1): " partition_name
            echo "Recovering files from $partition_name..."
            sudo photorec /dev/$partition_name
            ;;
        4)
            echo "Exiting File Recovery Tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure PhotoRec is installed
if ! command -v photorec &> /dev/null; then
    echo "PhotoRec is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y testdisk
fi

# Main script execution
recover_files
clear
