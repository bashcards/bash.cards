#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to recover data using ddrescue
recover_data() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |             Nine of Diamonds: Recover Data from Failed Disks              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | 'ddrescue' is a data recovery tool designed for reading and copying data  |"
    echo "    | from corrupted or damaged drives. It creates a mapfile to track progress  |"
    echo "    | and skips bad sectors to maximize data recovery.                          |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Recover data from a disk to an image file                             |"
    echo "    |  2. Resume a previous recovery session                                    |"
    echo "    |  3. Show progress of a recovery operation                                 |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Recovering data to an image file..."
            read -p "Enter the source disk (e.g., /dev/sda): " source
            read -p "Enter the target image file (e.g., /path/to/image.img): " target
            read -p "Enter the mapfile location (e.g., /path/to/mapfile.map): " mapfile
            if [[ -n $source && -n $target && -n $mapfile ]]; then
                echo "Running 'ddrescue $source $target $mapfile'..."
                sudo ddrescue "$source" "$target" "$mapfile"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        2)
            echo "Resuming a previous recovery session..."
            read -p "Enter the source disk (e.g., /dev/sda): " source
            read -p "Enter the target image file (e.g., /path/to/image.img): " target
            read -p "Enter the mapfile location (e.g., /path/to/mapfile.map): " mapfile
            if [[ -n $source && -n $target && -n $mapfile ]]; then
                echo "Running 'ddrescue -r3 $source $target $mapfile'..."
                sudo ddrescue -r3 "$source" "$target" "$mapfile"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        3)
            echo "Displaying progress..."
            read -p "Enter the mapfile location (e.g., /path/to/mapfile.map): " mapfile
            if [[ -n $mapfile ]]; then
                echo "Running 'ddrescuelog -l $mapfile'..."
                sudo ddrescuelog -l "$mapfile"
            else
                echo "Invalid input. Returning to menu."
            fi
            ;;
        4)
            echo "Exiting ddrescue tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure ddrescue is available
if ! command -v ddrescue &> /dev/null; then
    echo "Error: 'ddrescue' is not installed on this system. Installing..."
    read -p "Scan 'y' to install ddrescue: " confirm
    if [[ $confirm == "y" ]]; then
        sudo apt-get update && sudo apt-get install -y gddrescue
    else
        echo "ddrescue is required for this card. Exiting..."
        exit 1
    fi
fi

# Main script execution
recover_data
clear
