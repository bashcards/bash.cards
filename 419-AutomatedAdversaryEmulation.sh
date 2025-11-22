#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

automated_adversary_emulation() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Two of Spades                |"
        echo "    |  Run Automated Adversary Emulation        |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Emulate lateral movement              |"
        echo "    |  2. Execute file discovery scenarios      |"
        echo "    |  3. Simulate credential access attempts   |"
        echo "    |  4. Launch persistence simulation         |"
        echo "    |  5. Perform automated network scans       |"
        echo "    |  6. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Emulating lateral movement...${RESET}"
                echo "Checking for accessible SSH servers:"
                ss -tuln | grep -i ssh | awk '{print $5}' | head -n 5 || echo "No accessible SSH servers found."
                ;;
            2)
                clear
                echo -e "${CYAN}Executing file discovery scenarios...${RESET}"
                echo "Searching for sensitive files (e.g., *.key, *.pem):"
                find / -type f \( -name "*.key" -o -name "*.pem" \) 2>/dev/null | head -n 5 || echo "No sensitive files found."
                ;;
            3)
                clear
                echo -e "${CYAN}Simulating credential access attempts...${RESET}"
                echo "Scanning for readable password files:"
                find /etc -type f -name "passwd" -exec cat {} \; | head -n 10 || echo "No readable password files found."
                ;;
            4)
                clear
                echo -e "${CYAN}Launching persistence simulation...${RESET}"
                echo "Creating test autostart script:"
                mkdir -p /tmp/test_autostart
                echo '#!/bin/bash' > /tmp/test_autostart/startup.sh
                echo 'echo "Test Autostart Running"' >> /tmp/test_autostart/startup.sh
                chmod +x /tmp/test_autostart/startup.sh
                echo "Test autostart script created in /tmp/test_autostart/startup.sh."
                ;;
            5)
                clear
                echo -e "${CYAN}Performing automated network scans...${RESET}"
                echo "Scanning for active devices on the local subnet:"
                ip a | grep "inet " | awk '{print $2}' | head -n 1 | cut -d/ -f1 | xargs -I {} ping -c 1 {}.1-254 2>/dev/null | grep "bytes from" | head -n 5 || echo "No active devices found."
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

automated_adversary_emulation
