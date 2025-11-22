#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

endpoint_monitor() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               Jack of Hearts              |"
        echo "    |    Detect Suspicious Endpoint Activities  |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. List active processes                 |"
        echo "    |  2. Monitor unusual resource usage        |"
        echo "    |  3. Check recent file modifications       |"
        echo "    |  4. Detect unusual login attempts         |"
        echo "    |  5. Monitor open network connections      |"
        echo "    |  6. View active users and sessions        |"
        echo "    |  7. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing active processes...${RESET}"
                ps aux | less
                ;;
            2)
                clear
                echo -e "${CYAN}Monitoring unusual resource usage...${RESET}"
                top -b -n 1 | head -n 20 || echo "Failed to monitor resource usage."
                ;;
            3)
                clear
                echo -e "${CYAN}Checking recent file modifications...${RESET}"
                read -p "Enter directory to scan (default: /var): " dir
                dir=${dir:-/var}
                find "$dir" -type f -mtime -1 2>/dev/null | less || echo "No recent file modifications found."
                ;;
            4)
                clear
                echo -e "${CYAN}Detecting unusual login attempts...${RESET}"
                if [ -f /var/log/auth.log ]; then
                    grep -i "failed" /var/log/auth.log | tail -n 20 | less
                elif [ -f /var/log/secure ]; then
                    grep -i "failed" /var/log/secure | tail -n 20 | less
                else
                    echo "Authentication logs not found."
                fi
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring open network connections...${RESET}"
                ss -tuln | less
                ;;
            6)
                clear
                echo -e "${CYAN}Viewing active users and sessions...${RESET}"
                w || echo "No active users or sessions found."
                ;;
            7)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        read -n 1 -s -r -p "Press any key to return to the main menu..."
    done
}

endpoint_monitor
