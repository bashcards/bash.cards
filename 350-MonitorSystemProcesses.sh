#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'

# Menu for the King of Hearts Card
king_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                             King of Hearts                              |"
    echo "     |                          Monitor System Processes                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a comprehensive system process monitoring           |"
    echo "     |  interface. Choose an option below to monitor or analyze processes.     |"
    echo "     |                                                                         |"
    echo "     |  1. Real-Time System Monitoring (top)                                   |"
    echo "     |  2. View Processes by Resource Usage                                    |"
    echo "     |  3. Filter Processes by User                                            |"
    echo "     |  4. Save Process Snapshot to File                                       |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) real_time_monitoring ;;
        2) resource_usage ;;
        3) filter_by_user ;;
        4) save_snapshot ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_hearts_menu ;;
    esac
}

# Option 1: Real-Time System Monitoring
real_time_monitoring() {
    clear
    echo -e "${CYAN}Starting Real-Time System Monitoring (Press Ctrl+C to exit):${RESET}"
    top
    king_of_hearts_menu
}

# Option 2: View Processes by Resource Usage
resource_usage() {
    clear
    echo -e "${CYAN}Processes Sorted by Resource Usage:${RESET}"
    echo -e "${GREEN}Top 20 CPU-Intensive Processes:${RESET}"
    ps aux --sort=-%cpu | head -n 20
    echo
    echo -e "${GREEN}Top 20 Memory-Intensive Processes:${RESET}"
    ps aux --sort=-%mem | head -n 20
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

# Option 3: Filter Processes by User
filter_by_user() {
    clear
    read -p "Enter the username to filter processes: " username
    if id "$username" &>/dev/null; then
        echo -e "${CYAN}Processes for user ${GREEN}$username:${RESET}"
        ps -u "$username" -o pid,cmd,%cpu,%mem --sort=-%cpu
    else
        echo -e "${RED}Error: User $username does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

# Option 4: Save Process Snapshot to File
save_snapshot() {
    clear
    local filename="process_snapshot_$(date +%F_%H-%M-%S).txt"
    echo -e "${CYAN}Saving current process snapshot to file: ${GREEN}$filename${RESET}"
    ps aux > "$filename"
    echo -e "${GREEN}Snapshot saved successfully to $filename.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

king_of_hearts_menu
