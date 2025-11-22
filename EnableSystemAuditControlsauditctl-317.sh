#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

enable_audit_controls() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                             Nine of Spades                               |"
        echo "    |                   Enable System Audit Controls with auditctl             |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Check if auditd is running                                           |"
        echo "    |  2. Add a rule to monitor a specific file                                |"
        echo "    |  3. List all current audit rules                                         |"
        echo "    |  4. Delete a specific audit rule                                         |"
        echo "    |  5. View recent audit logs                                               |"
        echo "    |  6. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Checking if auditd is running...${RESET}"
                sudo systemctl status auditd --no-pager
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}auditd is running.${RESET}"
                else
                    echo -e "${RED}auditd is not running. Starting it now...${RESET}"
                    sudo systemctl start auditd
                    echo -e "${GREEN}auditd started.${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter the path of the file to monitor: " filepath
                clear
                echo -e "${CYAN}Adding audit rule for $filepath...${RESET}"
                sudo auditctl -w "$filepath" -p rwxa -k file_monitor
                echo -e "${GREEN}Audit rule added for $filepath.${RESET}"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Listing all current audit rules...${RESET}"
                sudo auditctl -l
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                read -p "Enter the path of the file to remove from monitoring: " filepath
                clear
                echo -e "${CYAN}Deleting audit rule for $filepath...${RESET}"
                sudo auditctl -W "$filepath"
                echo -e "${GREEN}Audit rule removed for $filepath.${RESET}"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Viewing recent audit logs...${RESET}"
                sudo ausearch -m FILE -i | tail -n 50
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo -e "${RED}Invalid choice. Please try again.${RESET}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

enable_audit_controls
