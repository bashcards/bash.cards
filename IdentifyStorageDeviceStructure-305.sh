#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

identify_storage() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |        Jack of Diamonds: Identify Storage Device Structure                |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | The following tools and options allow you to explore and manage storage   |"
    echo "    | devices on your Linux system.                                             |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. View all block devices (lsblk)                                        |"
    echo "    |  2. View detailed block device info with filesystem (lsblk -f)            |"
    echo "    |  3. View partition table (fdisk -l)                                       |"
    echo "    |  4. Check mounted partitions (df -h)                                      |"
    echo "    |  5. Show disk usage by directories (du -sh *)                             |"
    echo "    |  6. Identify unused partitions                                            |"
    echo "    |  7. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Displaying all block devices..."
            lsblk
            ;;
        2)
            echo "Displaying detailed block device information..."
            lsblk -f
            ;;
        3)
            echo "Displaying partition table for all disks..."
            sudo fdisk -l
            ;;
        4)
            echo "Displaying mounted partitions and their usage..."
            df -h
            ;;
        5)
            echo "Displaying disk usage by directories in the current directory..."
            du -sh *
            ;;
        6)
            echo "Identifying unused partitions..."
            echo "Comparing /etc/fstab entries and currently mounted devices..."
            grep -v '^#' /etc/fstab | awk '{print $1}' | while read -r fstab_device; do
                if ! mount | grep -q "$fstab_device"; then
                    echo "Unutilized partition: $fstab_device"
                fi
            done
            ;;
        7)
            echo "Exiting storage identification tool."
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
for cmd in lsblk fdisk df du; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
identify_storage
clear
