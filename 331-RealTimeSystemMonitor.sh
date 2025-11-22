#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

monitor_system_status() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                  Nine of Clubs: Real-Time System Monitor                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This card allows you to monitor key system metrics in real-time.          |"
    echo "    | Use the menu below to choose what you’d like to monitor.                  |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Monitor disk usage (df -h)                                            |"
    echo "    |  2. Monitor CPU usage (top command)                                       |"
    echo "    |  3. Monitor memory usage (free -h)                                        |"
    echo "    |  4. Monitor a custom command                                              |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Monitoring disk usage..."
            watch -n 1 df -h
            ;;
        2)
            echo "Monitoring CPU usage..."
            watch -n 1 "top -bn1 | head -n 10"
            ;;
        3)
            echo "Monitoring memory usage..."
            watch -n 1 free -h
            ;;
        4)
            read -p "Enter the custom command to monitor: " custom_command
            echo "Monitoring custom command output..."
            watch -n 1 "$custom_command"
            ;;
        5)
            echo "Exiting Real-Time System Monitor."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `watch` command is available
if ! command -v watch &> /dev/null; then
    echo "Error: Required command 'watch' is not available. Ensure your system has it installed."
    exit 1
fi

# Main script execution
monitor_system_status
clear
