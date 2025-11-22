#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

mitre_attack_mapping() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |             Three of Spades               |"
        echo "    |  Map Techniques to MITRE ATT&CK Framework |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Search known tactics by keyword       |"
        echo "    |  2. Analyze running processes for patterns|"
        echo "    |  3. Inspect network activity for tactics  |"
        echo "    |  4. Map recent file changes to techniques |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Searching known tactics by keyword...${RESET}"
                read -p "Enter a keyword to search (e.g., persistence, lateral movement): " keyword
                echo "Fetching results related to '$keyword' from available documentation..."
                grep -i "$keyword" /usr/share/doc/mitre-attack-docs/*.txt 2>/dev/null || echo "No results found for '$keyword'."
                ;;
            2)
                clear
                echo -e "${CYAN}Analyzing running processes for patterns...${RESET}"
                echo "Scanning running processes for suspicious activity:"
                ps aux | grep -E "nc|ssh|wget|curl" || echo "No suspicious processes found."
                ;;
            3)
                clear
                echo -e "${CYAN}Inspecting network activity for tactics...${RESET}"
                echo "Analyzing open network connections for potential misuse:"
                ss -tulnp | awk '{print $1, $5, $6}' | grep -E "ssh|http|ftp" || echo "No suspicious network activity detected."
                ;;
            4)
                clear
                echo -e "${CYAN}Mapping recent file changes to techniques...${RESET}"
                echo "Checking filesystem changes in the past 24 hours:"
                find / -type f -mtime -1 2>/dev/null | grep -E "cron|ssh|config" || echo "No significant changes detected."
                ;;
            5)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the menu...${RESET}"
        read -n 1 -s
    done
}

mitre_attack_mapping
