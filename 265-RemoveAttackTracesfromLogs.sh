#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Clubs Card
jack_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                               Jack of Clubs                              |"
    echo "     |                    Remove Attack Traces from Logs                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to selectively remove or obfuscate attack      |"
    echo "     |  traces from system logs to reduce the risk of detection.                |"
    echo "     |                                                                         |"
    echo "     |  1. View System Logs                                                    |"
    echo "     |  2. Remove Specific Entries from Logs                                   |"
    echo "     |  3. Clear All Logs                                                      |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_system_logs ;;
        2) remove_log_entries ;;
        3) clear_all_logs ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_clubs_menu ;;
    esac
}

# View System Logs
view_system_logs() {
    clear
    echo -e "${CYAN}Viewing system logs...${RESET}"
    if [ -f "/var/log/syslog" ]; then
        less /var/log/syslog
    elif [ -f "/var/log/messages" ]; then
        less /var/log/messages
    else
        echo "No system logs found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Remove Specific Entries from Logs
remove_log_entries() {
    clear
    echo -e "${CYAN}Removing specific entries from logs...${RESET}"
    read -p "Enter the keyword or pattern to search for in logs: " pattern
    temp_file=$(mktemp)
    if [ -f "/var/log/syslog" ]; then
        grep -v "$pattern" /var/log/syslog > "$temp_file" && mv "$temp_file" /var/log/syslog
        echo "Removed entries matching '$pattern' from /var/log/syslog."
    elif [ -f "/var/log/messages" ]; then
        grep -v "$pattern" /var/log/messages > "$temp_file" && mv "$temp_file" /var/log/messages
        echo "Removed entries matching '$pattern' from /var/log/messages."
    else
        echo "No system logs found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

# Clear All Logs
clear_all_logs() {
    clear
    echo -e "${CYAN}Clearing all system logs...${RESET}"
    read -p "Are you sure you want to clear all logs? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        if [ -f "/var/log/syslog" ]; then
            > /var/log/syslog
            echo "/var/log/syslog cleared."
        fi
        if [ -f "/var/log/messages" ]; then
            > /var/log/messages
            echo "/var/log/messages cleared."
        fi
    else
        echo "Operation canceled."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_clubs_menu
}

jack_of_clubs_menu
