#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

sysmon_events() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |              Ace of Diamonds             |"
        echo "    |        Monitor and Log System Events     |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. View live system logs                |"
        echo "    |  2. Monitor process creation events      |"
        echo "    |  3. Track file access operations         |"
        echo "    |  4. Inspect system log summaries         |"
        echo "    |  5. Monitor network connections          |"
        echo "    |  6. Analyze user login/logout activity   |"
        echo "    |  7. Search logs for specific events      |"
        echo "    |  8. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Viewing live system logs (Ctrl+C to exit)...${RESET}"
                sudo journalctl -f
                ;;
            2)
                clear
                echo -e "${CYAN}Monitoring process creation events...${RESET}"
                sudo journalctl -u auditd --since "1 hour ago" | grep "EXECVE"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Tracking file access operations...${RESET}"
                echo -e "${CYAN}Logs of file read/write detected:${RESET}"
                sudo ausearch -f / --since "1 hour ago" | less
                ;;
            4)
                clear
                echo -e "${CYAN}Inspecting system log summaries...${RESET}"
                sudo journalctl --since "today" | awk '{print $1, $2, $3, $5}' | less
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring active network connections (Ctrl+C to exit)...${RESET}"
                sudo ss -tunap | less
                ;;
            6)
                clear
                echo -e "${CYAN}Analyzing user login/logout activity:${RESET}"
                last -a | less
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            7)
                clear
                echo -e "${CYAN}Search logs for specific events.${RESET}"
                read -p "Enter keyword to search for: " keyword
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
    done
}

sysmon_events
