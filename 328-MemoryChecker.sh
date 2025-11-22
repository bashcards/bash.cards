#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

check_memory_availability() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                           Six of Clubs: Memory Checker                    |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides various options to check and analyze memory usage.     |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Display summary of memory usage                                       |"
    echo "    |  2. Show memory usage with human-readable values                          |"
    echo "    |  3. Monitor real-time memory usage                                        |"
    echo "    |  4. Show memory usage per process                                         |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Memory Usage Summary:"
            free
            ;;
        2)
            echo "Memory Usage (Human-Readable):"
            free -h
            ;;
        3)
            echo "Real-Time Memory Usage (Press Ctrl+C to stop):"
            watch -n 1 free -h
            ;;
        4)
            echo "Memory Usage Per Process:"
            echo "Press Ctrl+C to stop."
            ps aux --sort=-%mem | awk 'NR<=10{print $0}'
            ;;
        5)
            echo "Exiting Memory Checker."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `free` command is available
if ! command -v free &> /dev/null; then
    echo "Error: Required command 'free' is not available. Ensure your system has it installed."
    exit 1
fi

# Main script execution
check_memory_availability
clear
