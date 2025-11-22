#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

inspect_system_logs() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                   Ten of Clubs: Detailed System Logs Viewer               |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This card allows you to inspect detailed system logs using journalctl.    |"
    echo "    | Use the menu below to filter and view logs.                               |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. View all logs                                                         |"
    echo "    |  2. View logs for a specific service                                      |"
    echo "    |  3. View logs within a time range                                         |"
    echo "    |  4. Search logs for a specific keyword                                    |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Displaying all logs..."
            journalctl | less
            ;;
        2)
            read -p "Enter the service name (e.g., sshd, nginx): " service
            echo "Displaying logs for service: $service"
            journalctl -u "$service" | less
            ;;
        3)
            read -p "Enter start time (e.g., '2023-12-01 10:00:00'): " start_time
            read -p "Enter end time (e.g., '2023-12-01 12:00:00'): " end_time
            echo "Displaying logs from $start_time to $end_time..."
            journalctl --since "$start_time" --until "$end_time" | less
            ;;
        4)
            read -p "Enter the keyword to search for: " keyword
            echo "Searching logs for keyword: $keyword"
            journalctl | grep -i "$keyword" | less
            ;;
        5)
            echo "Exiting System Logs Viewer."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `journalctl` is available
if ! command -v journalctl &> /dev/null; then
    echo "Error: Required command 'journalctl' is not available. Ensure your system supports systemd."
    exit 1
fi

# Main script execution
inspect_system_logs
clear
