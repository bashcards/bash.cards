#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

simulate_attack_patterns() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Ten of Spades                |"
        echo "    | Simulate Advanced Attack Patterns in Logs |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Search Logs for Brute-Force Attempts  |"
        echo "    |  2. Identify Possible DDoS Patterns       |"
        echo "    |  3. Correlate Log Entries Across Files    |"
        echo "    |  4. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Searching logs for brute-force attempts...${RESET}"
                grep -i "failed" /var/log/auth.log /var/log/secure /var/log/messages 2>/dev/null | tail -n 20
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Analyzing logs for DDoS patterns...${RESET}"
                grep -i "connection" /var/log/syslog /var/log/messages 2>/dev/null | sort | uniq -c | sort -nr | head -n 20
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Correlating log entries across files...${RESET}"
                awk '{print $1, $2, $3}' /var/log/syslog /var/log/messages /var/log/auth.log 2>/dev/null | sort | uniq -c | sort -nr | head -n 20
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

simulate_attack_patterns
