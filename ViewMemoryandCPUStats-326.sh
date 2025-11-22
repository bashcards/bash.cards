#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

view_memory_cpu_stats() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                   Four of Clubs: View Memory and CPU Stats                |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides multiple options for monitoring memory and CPU stats.  |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Display real-time CPU and memory usage with 'vmstat'                  |"
    echo "    |  2. View system memory info (free -h)                                     |"
    echo "    |  3. Display CPU information (lscpu)                                       |"
    echo "    |  4. Check load averages                                                   |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Real-time CPU and Memory Usage:"
            echo "Press Ctrl+C to stop monitoring."
            vmstat 1
            ;;
        2)
            echo "System Memory Info:"
            free -h
            ;;
        3)
            echo "CPU Information:"
            lscpu
            ;;
        4)
            echo "System Load Averages (last 1, 5, and 15 minutes):"
            uptime
            ;;
        5)
            echo "Exiting memory and CPU stats viewer."
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
for cmd in vmstat free lscpu uptime; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
view_memory_cpu_stats
clear
