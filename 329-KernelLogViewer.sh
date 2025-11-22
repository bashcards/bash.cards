#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

view_kernel_logs() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                        Seven of Clubs: Kernel Log Viewer                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides options to view and analyze kernel logs for issues.    |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Display the latest kernel logs                                        |"
    echo "    |  2. Filter kernel logs by keyword                                         |"
    echo "    |  3. View kernel logs in real-time                                         |"
    echo "    |  4. Save kernel logs to a file                                            |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Latest Kernel Logs:"
            dmesg | tail -n 50
            ;;
        2)
            read -p "Enter a keyword to filter logs: " keyword
            echo "Filtered Kernel Logs for '$keyword':"
            dmesg | grep -i "$keyword"
            ;;
        3)
            echo "Real-Time Kernel Logs (Press Ctrl+C to stop):"
            dmesg -w
            ;;
        4)
            read -p "Enter a filename to save logs (e.g., kernel_logs.txt): " filename
            dmesg > "$filename"
            echo "Kernel logs saved to $filename."
            ;;
        5)
            echo "Exiting Kernel Log Viewer."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `dmesg` command is available
if ! command -v dmesg &> /dev/null; then
    echo "Error: Required command 'dmesg' is not available. Ensure your system has it installed."
    exit 1
fi

# Main script execution
view_kernel_logs
clear
