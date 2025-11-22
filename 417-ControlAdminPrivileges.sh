#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

admin_privilege_mgmt() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _________________________________________"
        echo "    |             King of Diamonds            |"
        echo "    |   Control and Monitor Admin Privileges  |"
        echo "    |_________________________________________|"
        echo "    |                                         |"
        echo "    |  1. List current sudo users             |"
        echo "    |  2. Monitor privilege escalation events |"
        echo "    |  3. Review sudo command logs            |"
        echo "    |  4. Revoke admin privileges             |"
        echo "    |  5. Set up alerts for privilege misuse  |"
        echo "    |  6. Exit                                |"
        echo "    |_________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing current sudo users...${RESET}"
                grep '^sudo:' /etc/group | cut -d: -f4 | tr ',' '\n' || \
                echo -e "${CYAN}Failed to retrieve sudo users.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Monitoring privilege escalation events... Press Ctrl+C to stop.${RESET}"
                tail -f /var/log/auth.log | grep --line-buffered 'sudo' || \
                echo -e "${CYAN}Privilege escalation monitoring not available.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Reviewing sudo command logs...${RESET}"
                if [ -f /var/log/sudo.log ]; then
                    cat /var/log/sudo.log | less
                else
                    echo -e "${CYAN}No sudo logs found.${RESET}"
                fi
                ;;
            4)
                clear
                echo -e "${CYAN}Revoking admin privileges...${RESET}"
                read -p "Enter the username to remove from sudo group: " username
                sudo deluser "$username" sudo && \
                echo -e "${CYAN}Admin privileges revoked for $username.${RESET}" || \
                echo -e "${CYAN}Failed to revoke privileges for $username.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Setting up alerts for privilege misuse...${RESET}"
                echo "auditctl -w /etc/sudoers -p wa -k sudo_changes" | sudo tee -a /etc/audit/rules.d/audit.rules >/dev/null && \
                sudo systemctl restart auditd && \
                echo -e "${CYAN}Alerts set up successfully. Privilege misuse will be logged.${RESET}" || \
                echo -e "${CYAN}Failed to set up alerts.${RESET}"
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

admin_privilege_mgmt
