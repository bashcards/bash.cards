#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

# Menu for the Ten of Hearts Card
ten_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ten of Hearts                              |"
    echo "     |                        Display Directory Disk Usage                     |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to analyze disk usage at the directory level. |"
    echo "     |                                                                         |"
    echo "     |  1. View Total Usage for Current Directory                              |"
    echo "     |  2. View Detailed Usage for Subdirectories                              |"
    echo "     |  3. Check Largest Directories in Current Directory                      |"
    echo "     |  4. Analyze a Specific Directory's Usage                                |"
    echo "     |  5. Monitor Directory Disk Usage in Real-Time                           |"
    echo "     |  6. Return to Main Menu                                                 |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) total_usage ;;
        2) detailed_usage ;;
        3) largest_directories ;;
        4) specific_directory ;;
        5) monitor_directory ;;
        6) exit ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_hearts_menu ;;
    esac
}

# Option 1: View Total Usage for Current Directory
total_usage() {
    clear
    echo -e "${CYAN}Total Disk Usage for Current Directory:${RESET}"
    du -sh .
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# Option 2: View Detailed Usage for Subdirectories
detailed_usage() {
    clear
    echo -e "${CYAN}Detailed Disk Usage for Subdirectories:${RESET}"
    du -h --max-depth=1 | sort -hr
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# Option 3: Check Largest Directories in Current Directory
largest_directories() {
    clear
    echo -e "${CYAN}Largest Directories in Current Directory:${RESET}"
    du -h --max-depth=1 | sort -hr | head -n 10
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# Option 4: Analyze a Specific Directory's Usage
specific_directory() {
    clear
    read -p "Enter the directory to analyze (default: current directory): " dir
    dir=${dir:-.}
    if [[ -d "$dir" ]]; then
        echo -e "${CYAN}Disk Usage for ${dir}:${RESET}"
        du -h --max-depth=1 "$dir" | sort -hr
    else
        echo -e "${RED}Error: Directory $dir does not exist.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# Option 5: Monitor Directory Disk Usage in Real-Time
monitor_directory() {
    clear
    echo -e "${CYAN}Monitoring Directory Disk Usage in Real-Time (Press Ctrl+C to stop):${RESET}"
    watch -n 2 'du -h --max-depth=1 | sort -hr'
    ten_of_hearts_menu
}

ten_of_hearts_menu
