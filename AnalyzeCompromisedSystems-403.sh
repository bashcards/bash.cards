#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_system() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               Queen of Hearts             |"
        echo "    |       Analyze Compromised Systems         |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Analyze running processes             |"
        echo "    |  2. Search for suspicious files           |"
        echo "    |  3. Inspect open network ports            |"
        echo "    |  4. Check for kernel log anomalies        |"
        echo "    |  5. Identify large or hidden files        |"
        echo "    |  6. Inspect recent user activity          |"
        echo "    |  7. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing running processes...${RESET}"
                ps aux | less
                ;;
            2)
                clear
                echo -e "${CYAN}Searching for suspicious files...${RESET}"
                read -p "Enter a directory to search (default: /): " dir
                dir=${dir:-/}
                find "$dir" -type f \( -name "*.sh" -o -name "*.exe" -o -name "*.bin" \) -exec ls -lh {} + 2>/dev/null | less
                ;;
            3)
                clear
                echo -e "${CYAN}Inspecting open network ports...${RESET}"
                netstat -tuln | less
                ;;
            4)
                clear
                echo -e "${CYAN}Checking kernel log anomalies...${RESET}"
                dmesg | grep -iE "error|fail|warn" | less
                ;;
            5)
                clear
                echo -e "${CYAN}Identifying large or hidden files...${RESET}"
                find / -type f -size +1G -exec ls -lh {} + 2>/dev/null | less
                find / -type f -name ".*" -exec ls -lh {} + 2>/dev/null | less
                ;;
            6)
                clear
                echo -e "${CYAN}Inspecting recent user activity...${RESET}"
                last | less
                ;;
            7)
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

analyze_system
