#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to mount recovered storage
mount_storage() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                  Ten of Diamonds: Mount Recovered Storage                 |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | The 'mount' command allows you to attach a recovered file system to your  |"
    echo "    | system for data access and recovery verification.                         |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Mount a storage device                                                |"
    echo "    |  2. View currently mounted devices                                        |"
    echo "    |  3. Unmount a storage device                                              |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Mount a storage device..."
            read -p "Enter the device path (e.g., /dev/sdb1): " device
            read -p "Enter the mount point (e.g., /mnt/recovered): " mount_point
            if [[ -n $device && -n $mount_point ]]; then
                sudo mkdir -p "$mount_point"
                echo "Mounting $device at $mount_point..."
                sudo mount "$device" "$mount_point" && echo "Successfully mounted $device at $mount_point."
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        2)
            echo "Currently mounted devices:"
            mount | column -t
            ;;
        3)
            echo "Unmount a storage device..."
            read -p "Enter the mount point to unmount (e.g., /mnt/recovered): " mount_point
            if [[ -n $mount_point ]]; then
                echo "Unmounting $mount_point..."
                sudo umount "$mount_point" && echo "Successfully unmounted $mount_point."
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        4)
            echo "Exiting mount tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure mount is available (should be pre-installed on most Linux systems)
if ! command -v mount &> /dev/null; then
    echo "Error: 'mount' command is not available. This card cannot be used on this system."
    exit 1
fi

# Main script execution
mount_storage
clear
