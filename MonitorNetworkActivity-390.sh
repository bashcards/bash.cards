#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

monitor_network_anomalies() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               Ace of Hearts               |"
        echo "    |    Monitor Network Activity for Anomalies |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. View active connections (ss/netstat)  |"
        echo "    |  2. Check network traffic anomalies       |"
        echo "    |  3. Analyze logs for unusual behavior     |"
        echo "    |  4. Inspect processes with network access |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Viewing active network connections...${RESET}"
                ss -tuln || netstat -tuln
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            2)
                clear
                echo -e "${CYAN}Checking network traffic anomalies...${RESET}"
                tcpdump -c 20 -i any
                echo -e "${CYAN}Traffic capture completed. Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            3)
                clear
                echo -e "${CYAN}Analyzing logs for unusual behavior...${RESET}"
                grep -iE "error|fail|unauthorized|suspicious" /var/log/syslog /var/log/messages /var/log/auth.log 2>/dev/null | less
                echo -e "${CYAN}Log analysis completed. Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            4)
                clear
                echo -e "${CYAN}Inspecting processes with network access...${RESET}"
                lsof -i -P -n | grep -i ESTABLISHED | less
                echo -e "${CYAN}Process inspection completed. Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            5)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
    done
}

monitor_network_anomalies
