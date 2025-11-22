#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

reformat_storage() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                   King of Diamonds: Reformat Storage Devices              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | Use this tool to reformat storage devices with different filesystems.     |"
    echo "    | WARNING: Reformatting will erase all data on the selected partition.      |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. List all available disks and partitions                               |"
    echo "    |  2. Format a partition with a specific filesystem                         |"
    echo "    |  3. Wipe a partition before formatting                                    |"
    echo "    |  4. Check filesystem consistency after formatting                         |"
    echo "    |  5. Label a formatted partition                                           |"
    echo "    |  6. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Listing all available disks and partitions..."
            sudo fdisk -l
            ;;
        2)
            echo "Formatting a partition..."
            read -p "Enter the partition to format (e.g., /dev/sda1): " partition
            read -p "Enter the filesystem type (e.g., ext4, xfs, ntfs, fat32): " fs_type
            if [ -b "$partition" ]; then
                echo "Formatting $partition as $fs_type..."
                sudo mkfs."$fs_type" "$partition"
            else
                echo "Invalid partition. Make sure it exists and try again."
            fi
            ;;
        3)
            echo "Wiping a partition before formatting..."
            read -p "Enter the partition to wipe (e.g., /dev/sda1): " partition
            if [ -b "$partition" ]; then
                echo "Wiping $partition securely. This may take some time..."
                sudo wipefs -a "$partition"
                echo "Partition wiped."
            else
                echo "Invalid partition. Make sure it exists and try again."
            fi
            ;;
        4)
            echo "Checking filesystem consistency..."
            read -p "Enter the partition to check (e.g., /dev/sda1): " partition
            if [ -b "$partition" ]; then
                echo "Checking filesystem consistency on $partition..."
                sudo fsck "$partition"
            else
                echo "Invalid partition. Make sure it exists and try again."
            fi
            ;;
        5)
            echo "Labeling a formatted partition..."
            read -p "Enter the partition to label (e.g., /dev/sda1): " partition
            read -p "Enter the label name: " label
            if [ -b "$partition" ]; then
                echo "Labeling $partition with name $label..."
                sudo e2label "$partition" "$label"
            else
                echo "Invalid partition. Make sure it exists and try again."
            fi
            ;;
        6)
            echo "Exiting the reformatting tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure required commands are available
for cmd in fdisk mkfs wipefs fsck e2label; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
reformat_storage
clear
