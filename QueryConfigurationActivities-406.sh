#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

osquery_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _____________________________________________"
        echo "    |                Two of Diamonds              |"
        echo "    |  Query Endpoint Configurations & Activities |"
        echo "    |_____________________________________________|"
        echo "    |                                             |"
        echo "    |  1. List installed software                 |"
        echo "    |  2. View running processes                  |"
        echo "    |  3. Check logged-in users                   |"
        echo "    |  4. View network connections                |"
        echo "    |  5. Query active services                   |"
        echo "    |  6. Inspect file changes                    |"
        echo "    |  7. Search logs for anomalies               |"
        echo "    |  8. Exit                                    |"
        echo "    |_____________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing installed software:${RESET}"
                dpkg-query -l | less
                ;;
            2)
                clear
                echo -e "${CYAN}Viewing running processes:${RESET}"
                ps aux | less
                ;;
            3)
                clear
                echo -e "${CYAN}Checking logged-in users:${RESET}"
                who | less
                ;;
            4)
                clear
                echo -e "${CYAN}Viewing network connections:${RESET}"
                ss -tunap | less
                ;;
            5)
                clear
                echo -e "${CYAN}Querying active services:${RESET}"
                systemctl list-units --type=service --state=active | less
                ;;
            6)
                clear
                echo -e "${CYAN}Inspecting recent file changes:${RESET}"
                sudo find / -type f -mtime -1 2>/dev/null | less
                ;;
            7)
                clear
                echo -e "${CYAN}Searching logs for anomalies:${RESET}"
                read -p "Enter keyword to search: " keyword
                sudo journalctl | grep -i "$keyword" | less
                ;;
            8)
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

osquery_menu
