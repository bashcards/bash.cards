#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

defense_scripts_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |             Five of Diamonds             |"
        echo "    |     Deploy Automated Defense Scripts     |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. Enable basic firewall rules          |"
        echo "    |  2. Detect brute force login attempts    |"
        echo "    |  3. Block suspicious IPs                 |"
        echo "    |  4. Monitor file system changes          |"
        echo "    |  5. Setup periodic log scanning          |"
        echo "    |  6. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Enabling basic firewall rules...${RESET}"
                sudo iptables -P INPUT DROP
                sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
                sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
                sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
                echo -e "${CYAN}Firewall rules enabled.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Detecting brute force login attempts...${RESET}"
                sudo grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr
                ;;
            3)
                clear
                echo -e "${CYAN}Blocking suspicious IPs...${RESET}"
                read -p "Enter IP to block: " ip
                sudo iptables -A INPUT -s "$ip" -j DROP
                echo -e "${CYAN}IP $ip blocked.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Monitoring file system changes in /etc...${RESET}"
                sudo inotifywait -m /etc
                ;;
            5)
                clear
                echo -e "${CYAN}Setting up periodic log scanning...${RESET}"
                echo "*/30 * * * * grep 'Failed password' /var/log/auth.log >> /var/log/failed_attempts.log" | sudo tee -a /etc/crontab
                echo -e "${CYAN}Log scanning setup completed.${RESET}"
                ;;
            6)
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

defense_scripts_menu
