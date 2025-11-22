#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'

# Menu for the Nine of Hearts Card
nine_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Nine of Hearts                             |"
    echo "     |                         Show Available Disk Space                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides in-depth information about disk usage and space.    |"
    echo "     |                                                                         |"
    echo "     |  1. View Disk Space Summary                                             |"
    echo "     |  2. Detailed Disk Usage per Mount Point                                 |"
    echo "     |  3. Check Largest Files in a Directory                                  |"
    echo "     |  4. Monitor Disk Space Usage in Real-Time                               |"
    echo "     |  5. Identify Disks Near Capacity                                        |"
    echo "     |  6. Return to Main Menu                                                 |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_summary ;;
        2) view_detailed ;;
        3) largest_files ;;
        4) monitor_disk ;;
        5) disks_near_capacity ;;
        6) exit ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_hearts_menu ;;
    esac
}

# Option 1: View Disk Space Summary
view_summary() {
    clear
    echo -e "${CYAN}Disk Space Summary:${RESET}"
    df -h --output=source,size,used,avail,pcent | awk 'NR==1{printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5} NR>1{printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5}'
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

# Option 2: View Detailed Disk Usage
view_detailed() {
    clear
    echo -e "${CYAN}Detailed Disk Usage per Mount Point:${RESET}"
    df -h --output=source,fstype,size,used,avail,pcent,target | awk 'NR==1{printf "%-20s %-10s %-10s %-10s %-10s %-10s %-30s\n", $1, $2, $3, $4, $5, $6, $7} NR>1{printf "%-20s %-10s %-10s %-10s %-10s %-10s %-30s\n", $1, $2, $3, $4, $5, $6, $7}'
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

# Option 3: Check Largest Files in a Directory
largest_files() {
    clear
    read -p "Enter the directory to scan for largest files (default: current directory): " dir
    dir=${dir:-.}
    echo -e "${CYAN}Scanning for largest files in ${dir}...${RESET}"
    find "$dir" -type f -exec du -h {} + | sort -hr | head -n 10
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

# Option 4: Monitor Disk Space Usage in Real-Time
monitor_disk() {
    clear
    echo -e "${CYAN}Monitoring Disk Space in Real-Time (Press Ctrl+C to stop):${RESET}"
    watch -n 2 df -h --output=source,size,used,avail,pcent
    nine_of_hearts_menu
}

# Option 5: Identify Disks Near Capacity
disks_near_capacity() {
    clear
    echo -e "${CYAN}Disks Near Capacity:${RESET}"
    df -h --output=source,size,used,avail,pcent | awk '$5+0 > 80 {printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5}'
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

nine_of_hearts_menu
