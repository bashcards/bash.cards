#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

# Menu for the Queen of Hearts Card
queen_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                             Queen of Hearts                             |"
    echo "     |                         List Running Processes                          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to list, monitor, and analyze running         |"
    echo "     |  processes. Choose an option below to interact with the processes.      |"
    echo "     |                                                                         |"
    echo "     |  1. View All Running Processes                                          |"
    echo "     |  2. View Top Resource-Consuming Processes                               |"
    echo "     |  3. Monitor Processes in Real-Time                                      |"
    echo "     |  4. Search for a Specific Process                                       |"
    echo "     |  5. Kill a Process                                                      |"
    echo "     |  6. Return to Main Menu                                                 |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_all_processes ;;
        2) top_resource_consumers ;;
        3) monitor_processes ;;
        4) search_process ;;
        5) kill_process ;;
        6) exit ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_hearts_menu ;;
    esac
}

# Option 1: View All Running Processes
view_all_processes() {
    clear
    echo -e "${CYAN}All Running Processes:${RESET}"
    ps aux
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

# Option 2: View Top Resource-Consuming Processes
top_resource_consumers() {
    clear
    echo -e "${CYAN}Top Resource-Consuming Processes:${RESET}"
    ps aux --sort=-%cpu,-%mem | head -n 20
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

# Option 3: Monitor Processes in Real-Time
monitor_processes() {
    clear
    echo -e "${CYAN}Monitoring Processes in Real-Time (Press Ctrl+C to stop):${RESET}"
    top
    queen_of_hearts_menu
}

# Option 4: Search for a Specific Process
search_process() {
    clear
    read -p "Enter the process name or PID to search for: " search_term
    echo -e "${CYAN}Search Results:${RESET}"
    ps aux | grep -i --color=always "$search_term" | grep -v grep
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

# Option 5: Kill a Process
kill_process() {
    clear
    read -p "Enter the PID of the process to kill: " pid
    if [[ -n "$pid" ]]; then
        echo "Attempting to kill process with PID $pid..."
        if kill "$pid" &>/dev/null; then
            echo -e "${GREEN}Process $pid successfully killed.${RESET}"
        else
            echo -e "${RED}Failed to kill process $pid. You may need elevated privileges.${RESET}"
        fi
    else
        echo -e "${RED}No PID entered. Returning to menu.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

queen_of_hearts_menu
