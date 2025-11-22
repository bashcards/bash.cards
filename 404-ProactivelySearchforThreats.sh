#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

threat_hunting() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               King of Hearts              |"
        echo "    |      Proactively Search for Threats       |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Scan for unusual user activity        |"
        echo "    |  2. Check for suspicious processes        |"
        echo "    |  3. Inspect network traffic anomalies     |"
        echo "    |  4. Search for modified system binaries   |"
        echo "    |  5. Monitor live system changes           |"
        echo "    |  6. Identify rogue users or groups        |"
        echo "    |  7. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Scanning for unusual user activity...${RESET}"
                echo "Last logins:"
                last | head -n 20
                echo -e "\nRecent sudo attempts:"
                grep -i "sudo" /var/log/auth.log | tail -n 20 2>/dev/null || echo "No sudo logs found."
                ;;
            2)
                clear
                echo -e "${CYAN}Checking for suspicious processes...${RESET}"
                ps aux | awk '{if ($3 > 50.0) print $0}' | less || echo "No suspicious processes detected."
                ;;
            3)
                clear
                echo -e "${CYAN}Inspecting network traffic anomalies...${RESET}"
                ss -tulnp | grep -E "LISTEN|ESTAB" | less
                ;;
            4)
                clear
                echo -e "${CYAN}Searching for modified system binaries...${RESET}"
                find /usr/bin /bin -type f -exec md5sum {} + > /tmp/system_binaries.md5
                diff /tmp/system_binaries.md5 /tmp/baseline_binaries.md5 2>/dev/null || echo "No baseline available. Generate a baseline first."
                ;;
            5)
                clear
                echo -e "${CYAN}Monitoring live system changes...${RESET}"
                inotifywait -m /etc /usr /var -e modify,create,delete --format '%w%f %e' 2>/dev/null || echo "inotify-tools is required to monitor live changes."
                ;;
            6)
                clear
                echo -e "${CYAN}Identifying rogue users or groups...${RESET}"
                echo "Checking /etc/passwd for suspicious entries:"
                awk -F: '($3 == 0) {print $1 " has root privileges"}' /etc/passwd
                echo -e "\nChecking for empty passwords:"
                awk -F: '($2 == "") {print $1 " has an empty password"}' /etc/shadow
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

threat_hunting
