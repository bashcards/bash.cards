#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

dns_anomaly_menu() {
    clear
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                               Eight of Hearts                            |"
        echo "    |                        Query DNS Logs for Anomalies                      |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. View recent DNS queries                                              |"
        echo "    |  2. Search for suspicious domains                                        |"
        echo "    |  3. Identify high-frequency requests                                     |"
        echo "    |  4. Look for DNS tunneling indicators                                    |"
        echo "    |  5. Exit to main menu                                                    |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Recent DNS queries:${RESET}"
                journalctl -u systemd-resolved --since "10 minutes ago" | grep -i query
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter domain keyword to search: " keyword
                clear
                echo -e "${CYAN}Searching DNS logs for: $keyword${RESET}"
                journalctl -u systemd-resolved | grep -i "$keyword" || echo "No matches found."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}High-frequency DNS requests:${RESET}"
                journalctl -u systemd-resolved | grep query | awk '{print $NF}' | sort | uniq -c | sort -nr | head -20
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Checking for DNS tunneling patterns:${RESET}"
                journalctl -u systemd-resolved | grep query | awk '{print $NF}' | grep -E '[a-zA-Z0-9]{30,}' || echo "No suspicious patterns found."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                echo "Exiting to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

dns_anomaly_menu
