#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to manage snapshots with snapper
manage_snapshots() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                   Three of Diamonds: Snapshot Management                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool allows you to manage system snapshots using snapper.            |"
    echo "    | Select an option to proceed:                                              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Create a new snapshot                                                 |"
    echo "    |  2. List existing snapshots                                               |"
    echo "    |  3. Restore a snapshot                                                    |"
    echo "    |  4. Delete an existing snapshot                                           |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            read -p "Enter a description for the new snapshot: " description
            sudo snapper create --description "$description"
            echo "New snapshot created with description: $description."
            ;;
        2)
            echo "Listing all snapshots..."
            sudo snapper list
            ;;
        3)
            read -p "Enter the snapshot number to restore: " snapshot_number
            echo "Restoring snapshot $snapshot_number..."
            sudo snapper undochange "$snapshot_number..0"
            echo "Snapshot $snapshot_number restored."
            ;;
        4)
            read -p "Enter the snapshot number to delete: " snapshot_number
            echo "Deleting snapshot $snapshot_number..."
            sudo snapper delete "$snapshot_number"
            echo "Snapshot $snapshot_number deleted."
            ;;
        5)
            echo "Exiting snapshot management tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure snapper is installed
if ! command -v snapper &> /dev/null; then
    echo "Snapper is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y snapper
fi

# Main script execution
manage_snapshots
clear
