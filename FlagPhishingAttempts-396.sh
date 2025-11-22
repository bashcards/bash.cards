#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

flag_phishing_attempts() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |                Seven of Hearts            |"
        echo "    |           Flag Phishing Attempts          |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Scan email logs for suspicious links  |"
        echo "    |  2. Search system logs for phishing signs |"
        echo "    |  3. Check for fake login pages            |"
        echo "    |  4. Monitor DNS logs for anomalies        |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Scanning email logs for suspicious links (e.g., shortened URLs, unexpected domains)...${RESET}"
                grep -Ei "(http://|https://|tinyurl\.|bit\.ly|ow\.ly|t\.co)" /var/log/mail.log 2>/dev/null | less || echo -e "${CYAN}No suspicious links found in email logs.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Searching system logs for phishing-related events...${RESET}"
                grep -Ei "phish|malware|suspicious|unauthorized" /var/log/* 2>/dev/null | less || echo -e "${CYAN}No phishing-related entries found in system logs.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Checking for fake login pages in common web directories...${RESET}"
                find /var/www/html -type f \( -iname "*.html" -o -iname "*.php" \) -exec grep -Ei "(login|password|signin|authentication)" {} + 2>/dev/null | less || echo -e "${CYAN}No fake login pages detected.${RESET}"
                ;;
            4)
                clear
                echo -e "${CYAN}Monitoring DNS logs for anomalies (e.g., unusual queries)...${RESET}"
                if [ -f /var/log/dns.log ]; then
                    tail -n 50 /var/log/dns.log | grep -Ei "malware|phish|suspicious" | less || echo -e "${CYAN}No anomalies found in DNS logs.${RESET}"
                else
                    echo -e "${CYAN}DNS logs not found on this system.${RESET}"
                fi
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

flag_phishing_attempts
