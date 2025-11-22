#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

correlate_security_events() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Nine of Diamonds             |"
        echo "    |      Connect Related Security Events      |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Find connections between login and    |"
        echo "    |     access logs                           |"
        echo "    |  2. Trace suspicious IP activity          |"
        echo "    |  3. Correlate file modifications with     |"
        echo "    |     user sessions                         |"
        echo "    |  4. Cross-reference DNS and HTTP logs     |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Finding connections between login and access logs...${RESET}"
                LOGINS="/var/log/auth.log"
                ACCESS="/var/log/access.log"
                if [[ -f "$LOGINS" && -f "$ACCESS" ]]; then
                    echo -e "${CYAN}Correlating recent login attempts with access logs:${RESET}"
                    grep "Accepted" "$LOGINS" | awk '{print $11}' | while read -r user_ip; do
                        echo -e "${CYAN}Connections for IP $user_ip:${RESET}"
                        grep "$user_ip" "$ACCESS" | tail -n 10
                    done
                else
                    echo -e "${CYAN}Required logs not found. Ensure auth and access logs are available.${RESET}"
                fi
                ;;
            2)
                clear
                echo -e "${CYAN}Tracing suspicious IP activity...${RESET}"
                read -p "Enter an IP to trace: " suspicious_ip
                echo -e "${CYAN}Tracing logs for IP: $suspicious_ip${RESET}"
                grep -r "$suspicious_ip" /var/log/ 2>/dev/null | less || echo -e "${CYAN}No activity found for IP $suspicious_ip.${RESET}"
                ;;
            3)
                clear
                echo -e "${CYAN}Correlating file modifications with user sessions...${RESET}"
                echo -e "${CYAN}Recent file modifications:${RESET}"
                find /etc -type f -mtime -1 -exec ls -lh {} + | awk '{print $9}' | while read -r file; do
                    echo -e "${CYAN}Checking activity for $file:${RESET}"
                    grep "$(basename "$file")" /var/log/auth.log 2>/dev/null || echo "No user sessions found related to $file."
                done
                ;;
            4)
                clear
                echo -e "${CYAN}Cross-referencing DNS and HTTP logs...${RESET}"
                DNS_LOG="/var/log/dns.log"
                HTTP_LOG="/var/log/httpd/access.log"
                if [[ -f "$DNS_LOG" && -f "$HTTP_LOG" ]]; then
                    grep "query" "$DNS_LOG" | awk '{print $5}' | while read -r domain; do
                        echo -e "${CYAN}Checking HTTP access for domain $domain:${RESET}"
                        grep "$domain" "$HTTP_LOG" | tail -n 5 || echo "No HTTP requests found for $domain."
                    done
                else
                    echo -e "${CYAN}DNS or HTTP logs not found. Ensure both are available.${RESET}"
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

correlate_security_events
