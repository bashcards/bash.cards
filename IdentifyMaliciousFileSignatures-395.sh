#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

identify_malicious_files() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |               Six of Hearts               |"
        echo "    |   Identify Malicious File Signatures      |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Scan for suspicious file extensions   |"
        echo "    |  2. Check files against known hashes      |"
        echo "    |  3. Look for executable files in unusual  |"
        echo "    |     directories                           |"
        echo "    |  4. Analyze recently modified files       |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Scanning for suspicious file extensions (e.g., .exe, .dll, .bat)...${RESET}"
                find / -type f \( -iname "*.exe" -o -iname "*.dll" -o -iname "*.bat" -o -iname "*.js" -o -iname "*.vbs" \) 2>/dev/null | less || echo -e "${CYAN}No suspicious files found.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Checking files against known malicious hashes...${RESET}"
                read -p "Enter hash to check (SHA256): " hash
                find / -type f -exec sha256sum {} + 2>/dev/null | grep "$hash" | less || echo -e "${CYAN}No matches found for the provided hash.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Looking for executable files in unusual directories (e.g., /tmp, /var/tmp)...${RESET}"
                find /tmp /var/tmp -type f -executable 2>/dev/null | less || echo -e "${CYAN}No suspicious executables found.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Analyzing recently modified files (last 7 days)...${RESET}"
                find / -type f -mtime -7 2>/dev/null | less || echo -e "${CYAN}No recently modified files found.${RESET}"
                ;;
            5)
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

identify_malicious_files
