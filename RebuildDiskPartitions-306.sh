#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

rebuild_partitions() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                 Queen of Diamonds: Rebuild Disk Partitions                |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | Use this tool to manage and rebuild partitions on your disks. Choose from |"
    echo "    | the options below to perform different tasks related to disk partitions.  |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. List all disks and their partitions (fdisk -l)                        |"
    echo "    |  2. Create a new partition                                                |"
    echo "    |  3. Delete an existing partition                                          |"
    echo "    |  4. Format a partition (mkfs)                                             |"
    echo "    |  5. Label a partition                                                     |"
    echo "    |  6. View partition details with blkid                                     |"
    echo "    |  7. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Listing all disks and their partitions..."
            sudo fdisk -l
            ;;
        2)
            echo "Creating a new partition..."
            read -p "Enter the disk (e.g., /dev/sda): " disk
            if [ -b "$disk" ]; then
                sudo fdisk "$disk"
            else
                echo "Invalid disk. Make sure the disk exists and try again."
            fi
            ;;
        3)
            echo "Deleting an existing partition..."
            read -p "Enter the disk (e.g., /dev/sda): " disk
            if [ -b "$disk" ]; then
                echo "Starting fdisk for partition deletion..."
                sudo fdisk "$disk"
            else
                echo "Invalid disk. Make sure the disk exists and try again."
            fi
            ;;
        4)
            echo "Formatting a partition..."
            read -p "Enter the partition (e.g., /dev/sda1): " partition
            read -p "Enter the filesystem type (e.g., ext4, xfs): " fs_type
            if [ -b "$partition" ]; then
                echo "Formatting $partition as $fs_type..."
                sudo mkfs."$fs_type" "$partition"
            else
                echo "Invalid partition. Make sure the partition exists and try again."
            fi
            ;;
        5)
            echo "Labeling a partition..."
            read -p "Enter the partition (e.g., /dev/sda1): " partition
            read -p "Enter the label name: " label
            if [ -b "$partition" ]; then
                echo "Labeling $partition with name $label..."
                sudo e2label "$partition" "$label"
            else
                echo "Invalid partition. Make sure the partition exists and try again."
            fi
            ;;
        6)
            echo "Viewing partition details with blkid..."
            sudo blkid
            ;;
        7)
            echo "Exiting partition management tool."
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
for cmd in fdisk mkfs e2label blkid; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
rebuild_partitions
clear
