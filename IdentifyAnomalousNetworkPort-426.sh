#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

identify_anomalous_ports() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |              Nine of Spades              |"
        echo "    |     Identify Anomalous Network Ports     |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. List All Open Ports                  |"
        echo "    |  2. Scan for Unusual Listening Ports     |"
        echo "    |  3. Identify High-Traffic Ports          |"
        echo "    |  4. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing all open ports and associated services...${RESET}"
                netstat -tuln | awk '/LISTEN/ {print $1, $4, $5, $6}'
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Scanning for unusual listening ports...${RESET}"
                netstat -tuln | awk '/LISTEN/ {print $4}' | grep -v ":80$" | grep -v ":443$"
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Identifying high-traffic ports...${RESET}"
                ss -tan | awk '/ESTAB/ {split($5,a,":"); print a[length(a)]}' | sort | uniq -c | sort -nr
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            4)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
    done
}

identify_anomalous_ports
