#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

# Menu for the Jack of Hearts Card
jack_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Jack of Hearts                             |"
    echo "     |                          Display and Analyze Memory Usage               |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to monitor, analyze, and optimize memory      |"
    echo "     |  usage for your system.                                                 |"
    echo "     |                                                                         |"
    echo "     |  1. View Current Memory Usage Summary                                   |"
    echo "     |  2. View Detailed Memory Usage                                          |"
    echo "     |  3. Monitor Memory Usage in Real-Time                                   |"
    echo "     |  4. Analyze Swap Memory Usage                                           |"
    echo "     |  5. Clear Cache and Buffers                                             |"
    echo "     |  6. Return to Main Menu                                                 |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_memory_summary ;;
        2) detailed_memory_usage ;;
        3) monitor_memory_usage ;;
        4) analyze_swap_usage ;;
        5) clear_cache ;;
        6) exit ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_hearts_menu ;;
    esac
}

# Option 1: View Current Memory Usage Summary
view_memory_summary() {
    clear
    echo -e "${CYAN}Memory Usage Summary:${RESET}"
    free -h
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

# Option 2: View Detailed Memory Usage
detailed_memory_usage() {
    clear
    echo -e "${CYAN}Detailed Memory Usage:${RESET}"
    echo -e "${YELLOW}Total Memory:${RESET} $(free -h | awk '/^Mem:/ {print $2}')"
    echo -e "${YELLOW}Used Memory:${RESET} $(free -h | awk '/^Mem:/ {print $3}')"
    echo -e "${YELLOW}Available Memory:${RESET} $(free -h | awk '/^Mem:/ {print $7}')"
    echo -e "${YELLOW}Buffers/Cache:${RESET} $(free -h | awk '/^Mem:/ {print $6}')"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

# Option 3: Monitor Memory Usage in Real-Time
monitor_memory_usage() {
    clear
    echo -e "${CYAN}Monitoring Memory Usage in Real-Time (Press Ctrl+C to stop):${RESET}"
    watch -n 2 free -h
    jack_of_hearts_menu
}

# Option 4: Analyze Swap Memory Usage
analyze_swap_usage() {
    clear
    echo -e "${CYAN}Swap Memory Usage:${RESET}"
    free -h | awk '/^Swap:/ {printf "Total Swap: %s\nUsed Swap: %s\nFree Swap: %s\n", $2, $3, $4}'
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

# Option 5: Clear Cache and Buffers
clear_cache() {
    clear
    echo -e "${RED}Warning:${RESET} Clearing cache and buffers can affect system performance."
    read -p "Are you sure you want to clear cache and buffers? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "Clearing cache and buffers..."
        sudo sync; sudo sysctl -w vm.drop_caches=3
        echo "Cache and buffers cleared."
    else
        echo "Operation canceled."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_hearts_menu
}

jack_of_hearts_menu
