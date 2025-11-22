#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

simulate_adversary_tactics() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |                Ace of Spades              |"
        echo "    |       Simulate Adversary Tactics          |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Test credential dumping techniques    |"
        echo "    |  2. Simulate network reconnaissance       |"
        echo "    |  3. Emulate data exfiltration             |"
        echo "    |  4. Test persistence methods              |"
        echo "    |  5. Simulate privilege escalation         |"
        echo "    |  6. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Testing credential dumping techniques...${RESET}"
                echo "Using /etc/shadow for credential verification:"
                if [ -f /etc/shadow ]; then
                    cat /etc/shadow | awk -F: '($2 != "") {print $1}' | head -n 5
                else
                    echo "Credential file not found."
                fi
                ;;
            2)
                clear
                echo -e "${CYAN}Simulating network reconnaissance...${RESET}"
                echo "Performing ARP scan:"
                arp -a | head -n 10
                echo -e "\nChecking open ports:"
                ss -tuln | head -n 10
                ;;
            3)
                clear
                echo -e "${CYAN}Emulating data exfiltration...${RESET}"
                echo "Checking for writable directories in /tmp:"
                find /tmp -type d -writable | head -n 5
                ;;
            4)
                clear
                echo -e "${CYAN}Testing persistence methods...${RESET}"
                echo "Creating a test cron job (simulation only):"
                echo "* * * * * echo 'Test Job Running' >> /tmp/persistence.log" > /tmp/test_cron
                crontab /tmp/test_cron
                echo "Test cron job created."
                ;;
            5)
                clear
                echo -e "${CYAN}Simulating privilege escalation...${RESET}"
                echo "Checking for writable sudo binaries:"
                find /usr/bin -perm -o+w | head -n 5
                ;;
            6)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        read -n 1 -s -r -p "Press any key to return to the main menu..."
    done
}

simulate_adversary_tactics
