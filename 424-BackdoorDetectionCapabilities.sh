#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

secure_backdoor_card() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________"
        echo "    |             Seven of Spades              |"
        echo "    |   Test Backdoor Detection Capabilities   |"
        echo "    |__________________________________________|"
        echo "    |                                          |"
        echo "    |  1. Search for Suspicious Processes      |"
        echo "    |  2. Analyze Listening Ports              |"
        echo "    |  3. Scan for Hidden Files/Directories    |"
        echo "    |  4. Monitor File Changes in Real-Time    |"
        echo "    |  5. Exit                                 |"
        echo "    |__________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Searching for suspicious processes...${RESET}"
                ps aux | grep -E 'nc|netcat|bash|perl|python|sh' | grep -v grep
                echo -e "${CYAN}Search complete. Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Analyzing listening ports...${RESET}"
                ss -tuln
                echo -e "${CYAN}Analysis complete. Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Scanning for hidden files and directories...${RESET}"
                find / -type f -name ".*" -or -type d -name ".*" 2>/dev/null | less
                echo -e "${CYAN}Scan complete. Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            4)
                clear
                echo -e "${CYAN}Monitoring file changes in real-time...${RESET}"
                echo -e "${CYAN}Press Ctrl+C to stop.${RESET}"
                inotifywait -m -r / 2>/dev/null
                ;;
            5)
                echo -e "${CYAN}Exiting...${RESET}"
                break
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
    done
}

secure_backdoor_card
