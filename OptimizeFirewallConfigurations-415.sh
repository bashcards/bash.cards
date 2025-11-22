#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

optimize_firewall() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |             Jack of Diamonds             |"
        echo "    |     Optimize Firewall Configurations     |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. View active firewall rules           |"
        echo "    |  2. Add a new rule                       |"
        echo "    |  3. Remove an existing rule              |"
        echo "    |  4. Save firewall configuration          |"
        echo "    |  5. Restore default rules                |"
        echo "    |  6. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Active Firewall Rules:${RESET}"
                if command -v iptables > /dev/null; then
                    iptables -L -v -n
                elif command -v nft > /dev/null; then
                    nft list ruleset
                else
                    echo -e "${CYAN}No compatible firewall tool found.${RESET}"
                fi
                ;;
            2)
                clear
                echo -e "${CYAN}Adding a new firewall rule...${RESET}"
                read -p "Enter the rule (e.g., 'iptables -A INPUT -p tcp --dport 22 -j ACCEPT'): " new_rule
                eval "$new_rule" && echo -e "${CYAN}Rule added successfully.${RESET}" || echo -e "${CYAN}Failed to add rule.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Removing an existing firewall rule...${RESET}"
                read -p "Enter the rule to remove (e.g., 'iptables -D INPUT -p tcp --dport 22 -j ACCEPT'): " remove_rule
                eval "$remove_rule" && echo -e "${CYAN}Rule removed successfully.${RESET}" || echo -e "${CYAN}Failed to remove rule.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Saving firewall configuration...${RESET}"
                if command -v iptables-save > /dev/null; then
                    iptables-save > /etc/iptables/rules.v4 && echo -e "${CYAN}Configuration saved.${RESET}"
                elif command -v nft > /dev/null; then
                    nft list ruleset > /etc/nftables.conf && echo -e "${CYAN}Configuration saved.${RESET}"
                else
                    echo -e "${CYAN}No compatible firewall tool found to save configuration.${RESET}"
                fi
                ;;
            5)
                clear
                echo -e "${CYAN}Restoring default firewall rules...${RESET}"
                if command -v iptables > /dev/null; then
                    iptables -F && iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT
                    echo -e "${CYAN}Default rules restored.${RESET}"
                elif command -v nft > /dev/null; then
                    nft flush ruleset && echo -e "${CYAN}Default rules restored.${RESET}"
                else
                    echo -e "${CYAN}No compatible firewall tool found to restore default rules.${RESET}"
                fi
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

optimize_firewall
