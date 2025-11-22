#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

siem_tools_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |           Eight of Diamonds              |"
        echo "    |   Aggregate and Analyze Logs in SIEM     |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. View aggregated logs                 |"
        echo "    |  2. Search for specific events           |"
        echo "    |  3. Analyze failed login attempts        |"
        echo "    |  4. Check for suspicious file changes    |"
        echo "    |  5. Monitor live log activity            |"
        echo "    |  6. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Aggregated logs from common locations:${RESET}"
                LOG_FILES=("/var/log/syslog" "/var/log/messages" "/var/log/auth.log" "/var/log/kern.log")
                for LOG in "${LOG_FILES[@]}"; do
                    if [ -f "$LOG" ]; then
                        echo -e "${CYAN}Displaying last 50 lines of $LOG:${RESET}"
                        tail -n 50 "$LOG" | less
                    else
                        echo -e "${CYAN}Log file $LOG not found.${RESET}"
                    fi
                done
                ;;
            2)
                clear
                read -p "Enter keyword to search across logs: " keyword
                echo -e "${CYAN}Searching for '$keyword' in logs...${RESET}"
                grep -ri "$keyword" /var/log/ 2>/dev/null | less || echo -e "${CYAN}No matches found.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Analyzing failed login attempts:${RESET}"
                LOG_FILES=("/var/log/auth.log" "/var/log/secure")
                for LOG in "${LOG_FILES[@]}"; do
                    if [ -f "$LOG" ]; then
                        echo -e "${CYAN}Failed login attempts in $LOG:${RESET}"
                        grep -i "failed" "$LOG" | tail -n 20 | less
                    else
                        echo -e "${CYAN}No authentication logs found in $LOG.${RESET}"
                    fi
                done
                ;;
            4)
                clear
                echo -e "${CYAN}Checking for suspicious file changes (last modified within 24 hours):${RESET}"
                find /etc -type f -mtime -1 2>/dev/null | less || echo -e "${CYAN}No file changes detected.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring live log activity:${RESET}"
                echo -e "${CYAN}Press Ctrl+C to stop.${RESET}"
                tail -f /var/log/syslog /var/log/auth.log 2>/dev/null || echo -e "${CYAN}Unable to monitor logs live.${RESET}"
                ;;
            6)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Please select a valid option.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s -r
    done
}

siem_tools_menu
