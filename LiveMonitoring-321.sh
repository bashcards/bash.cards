#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to monitor live system changes
monitor_changes() {
    clear
    echo -e "${CYAN}"
    echo "     ____________________________________________________________________________"
    echo "    |                      Queen of Spades: Live Monitoring                     |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides options to monitor live changes to the system.         |"
    echo "    | Select an option to begin monitoring:                                     |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Monitor live file changes in /var/log                                 |"
    echo "    |  2. Monitor process creation and termination                              |"
    echo "    |  3. Monitor network connections in real-time                              |"
    echo "    |  4. Monitor changes to a specific directory                               |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            clear
            echo "Monitoring live file changes in /var/log. Press Ctrl+C to stop."
            sudo tail -f /var/log/*.log
            ;;
        2)
            clear
            echo "Monitoring process creation and termination. Press Ctrl+C to stop."
            sudo execsnoop
            ;;
        3)
            clear
            echo "Monitoring network connections in real-time. Press Ctrl+C to stop."
            sudo ss -tpw | watch -n 1
            ;;
        4)
            read -p "Enter the directory to monitor: " directory
            if [ -d "$directory" ]; then
                clear
                echo "Monitoring changes to directory: $directory. Press Ctrl+C to stop."
                sudo inotifywait -m -r "$directory"
            else
                echo "Directory not found. Returning to menu..."
            fi
            ;;
        5)
            echo "Exiting live monitoring."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac
}

# Main script execution
monitor_changes
clear
