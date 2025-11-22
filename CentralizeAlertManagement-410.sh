#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

centralize_alert_management() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |             Six of Diamonds              |"
        echo "    |      Centralize Alert Management         |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. View current system alerts           |"
        echo "    |  2. Export alerts to a centralized file  |"
        echo "    |  3. Set up periodic alert monitoring     |"
        echo "    |  4. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Fetching current system alerts...${RESET}"
                journalctl -p err -o short-iso --no-pager | tail -n 20
                echo -e "${CYAN}Displayed recent alerts.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Exporting alerts to a centralized file...${RESET}"
                export_file="/var/log/centralized_alerts.log"
                journalctl -p err -o short-iso > "$export_file"
                echo -e "${CYAN}Alerts exported to $export_file.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Setting up periodic alert monitoring...${RESET}"
                read -p "Enter interval in seconds (e.g., 10): " interval
                echo -e "${CYAN}Monitoring system alerts every $interval seconds. Press Ctrl+C to stop.${RESET}"
                while true; do
                    clear
                    echo -e "${CYAN}Recent Alerts:${RESET}"
                    journalctl -p err -o short-iso --no-pager | tail -n 10
                    sleep "$interval"
                done
                ;;
            4)
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

centralize_alert_management
