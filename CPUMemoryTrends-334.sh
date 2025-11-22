#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

cpu_memory_trends() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                      Queen of Clubs: CPU & Memory Trends                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This card allows you to inspect CPU and memory usage over time.           |"
    echo "    | Use the options below to monitor and analyze resource trends.             |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. View real-time CPU and memory usage                                   |"
    echo "    |  2. Analyze historical CPU and memory trends                              |"
    echo "    |  3. Inspect per-process CPU and memory usage                              |"
    echo "    |  4. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Real-time CPU and memory usage:"
            top -n 1 | head -n 15
            ;;
        2)
            echo "Historical CPU and memory trends:"
            echo "Generating 1-minute intervals for CPU and memory usage. Press Ctrl+C to stop."
            sar -u 1
            ;;
        3)
            read -p "Enter the name of the process to inspect (or leave blank for all): " process
            if [ -z "$process" ]; then
                echo "Displaying CPU and memory usage for all processes:"
                ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 15
            else
                echo "Displaying CPU and memory usage for process: $process"
                ps -C "$process" -o pid,comm,%cpu,%mem --sort=-%cpu
            fi
            ;;
        4)
            echo "Exiting CPU & Memory Trends."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure necessary commands are available
for cmd in top ps sar; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' is not available."
        exit 1
    fi
done

# Main script execution
cpu_memory_trends
clear
