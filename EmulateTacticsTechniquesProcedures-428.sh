#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

tactics_simulator() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _____________________________________________"
        echo "    |                Jack of Spades               |"
        echo "    | Emulate Tactics, Techniques, and Procedures |"
        echo "    |_____________________________________________|"
        echo "    |                                             |"
        echo "    |  1. Simulate Credential Harvesting          |"
        echo "    |  2. Test Lateral Movement Techniques        |"
        echo "    |  3. Emulate Data Exfiltration               |"
        echo "    |  4. Exit                                    |"
        echo "    |_____________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Simulating Credential Harvesting...${RESET}"
                echo "Checking for shadow file access..."
                if [ -r /etc/shadow ]; then
                    echo -e "${CYAN}Access to /etc/shadow detected!${RESET}"
                else
                    echo -e "${CYAN}Access to /etc/shadow denied.${RESET}"
                fi
                echo -e "${CYAN}Attempting to capture user credentials via SSH logs...${RESET}"
                grep -i "accepted password" /var/log/auth.log /var/log/secure 2>/dev/null | tail -n 20
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Testing Lateral Movement Techniques...${RESET}"
                echo "Searching for SSH keys..."
                find / -name "id_rsa" -o -name "id_dsa" -o -name "known_hosts" 2>/dev/null | less
                echo "Attempting to list writable directories for lateral movement..."
                find / -type d -writable 2>/dev/null | head -n 20
                echo -e "${CYAN}Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Emulating Data Exfiltration...${RESET}"
                echo "Locating large files to simulate exfiltration..."
                find / -type f -size +1G 2>/dev/null | less
                echo "Testing outbound connections using curl..."
                curl -Is http://example.com | head -n 5
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

tactics_simulator
