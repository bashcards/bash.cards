#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

psa_tools_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |             Four of Diamonds              |"
        echo "    |    Analyze Process & System Anomalies     |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. List top resource-consuming processes |"
        echo "    |  2. Identify orphaned or zombie processes |"
        echo "    |  3. Inspect processes by user             |"
        echo "    |  4. Search for specific processes         |"
        echo "    |  5. Monitor new processes in real-time    |"
        echo "    |  6. Check for unsigned binaries           |"
        echo "    |  7. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Top resource-consuming processes:${RESET}"
                ps -eo pid,ppid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 20
                ;;
            2)
                clear
                echo -e "${CYAN}Checking for orphaned or zombie processes...${RESET}"
                ps -eo pid,ppid,stat,cmd | grep -E '^[Z]'
                ;;
            3)
                clear
                echo -e "${CYAN}Inspecting processes by user...${RESET}"
                read -p "Enter username to inspect: " username
                ps -u "$username" -o pid,%cpu,%mem,cmd
                ;;
            4)
                clear
                echo -e "${CYAN}Searching for specific processes...${RESET}"
                read -p "Enter process name or keyword to search: " keyword
                ps aux | grep -i "$keyword" | grep -v "grep"
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring new processes in real-time...${RESET}"
                sudo watch -n 1 "ps -eo pid,ppid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 10"
                ;;
            6)
                clear
                echo -e "${CYAN}Checking for unsigned binaries...${RESET}"
                find /proc/*/exe -type l 2>/dev/null | while read -r exe; do
                    if ! file "$exe" | grep -q "ELF"; then
                        echo "Potential unsigned binary: $exe"
                    fi
                done
                ;;
            7)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s -r
    done
}

psa_tools_menu
