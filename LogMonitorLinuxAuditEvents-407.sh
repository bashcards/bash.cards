#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

auditd_menu() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |              Three of Diamonds           |"
        echo "    |    Log & Monitor Linux Audit Events      |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. Check audit daemon status            |"
        echo "    |  2. View recent audit logs               |"
        echo "    |  3. Monitor audit logs in real-time      |"
        echo "    |  4. Add a rule to monitor a directory    |"
        echo "    |  5. Remove a custom audit rule           |"
        echo "    |  6. View active audit rules              |"
        echo "    |  7. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Checking audit daemon status...${RESET}"
                sudo systemctl status auditd
                ;;
            2)
                clear
                echo -e "${CYAN}Displaying recent audit logs:${RESET}"
                sudo ausearch -m ALL -ts recent | less
                ;;
            3)
                clear
                echo -e "${CYAN}Monitoring audit logs in real-time:${RESET}"
                sudo tail -f /var/log/audit/audit.log
                ;;
            4)
                clear
                echo -e "${CYAN}Adding an audit rule to monitor a directory:${RESET}"
                read -p "Enter the directory to monitor: " dir
                sudo auditctl -w "$dir" -p war -k custom_monitor
                echo -e "${CYAN}Audit rule added for $dir.${RESET}"
                ;;
            5)
                clear
                echo -e "${CYAN}Removing a custom audit rule...${RESET}"
                read -p "Enter the key of the rule to remove (e.g., custom_monitor): " key
                sudo auditctl -d -k "$key"
                echo -e "${CYAN}Audit rule with key $key removed.${RESET}"
                ;;
            6)
                clear
                echo -e "${CYAN}Displaying active audit rules:${RESET}"
                sudo auditctl -l
                ;;
            7)
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

auditd_menu
