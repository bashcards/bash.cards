#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to switch to rescue mode
switch_to_rescue_mode() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                   Six of Diamonds: Switch to Rescue Mode                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | Rescue mode is a minimal system mode for maintenance and recovery.        |"
    echo "    | Ensure that all tasks are saved before proceeding.                        |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Switch to Rescue Mode                                                 |"
    echo "    |  2. View Active System Services                                           |"
    echo "    |  3. View Journal Logs Before Rescue Mode                                  |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Switching to Rescue Mode..."
            echo "This will disconnect your current session."
            read -p "Are you sure? (y/n): " confirm
            if [[ $confirm == "y" ]]; then
                sudo systemctl rescue
            else
                echo "Operation canceled. Returning to menu."
            fi
            ;;
        2)
            echo "Displaying active system services..."
            sudo systemctl list-units --type=service --state=running
            ;;
        3)
            echo "Viewing recent journal logs..."
            sudo journalctl -p 3 -n 50
            ;;
        4)
            echo "Exiting Rescue Mode tool."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure systemctl is available
if ! command -v systemctl &> /dev/null; then
    echo "Error: 'systemctl' is not available on this system. Exiting..."
    exit 1
fi

# Main script execution
switch_to_rescue_mode
clear
