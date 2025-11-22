#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

trace_ddos_sources() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     _________________________________________________________________________"
        echo "    |                                Ten of Hearts                            |"
        echo "    |                Trace the Source of Potential DDoS Attacks               |"
        echo "    |_________________________________________________________________________|"
        echo "    |                                                                         |"
        echo "    |  Options:                                                               |"
        echo "    |  1. Analyze live network traffic with netstat                           |"
        echo "    |  2. Check for suspicious traffic using ss                               |"
        echo "    |  3. Use tcpdump to capture and inspect packets                          |"
        echo "    |  4. View recent logs from /var/log/syslog or /var/log/messages          |"
        echo "    |  5. Return to main menu                                                 |"
        echo "    |_________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing live network traffic with netstat:${RESET}"
                netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -n 10 || echo "Error analyzing network traffic."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Checking for suspicious traffic using ss:${RESET}"
                ss -tn state established | awk '{print $5}' | sort | uniq -c | sort -nr | head -n 10 || echo "Error checking suspicious traffic."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Using tcpdump to capture and inspect packets:${RESET}"
                echo "Capturing top IP addresses from live traffic for 10 seconds..."
                sudo timeout 10 tcpdump -n -i any | awk '{print $3}' | cut -d. -f1-4 | sort | uniq -c | sort -nr | head -n 10 || echo "Error capturing packets."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Viewing recent logs from syslog or messages:${RESET}"
                if [ -f /var/log/syslog ]; then
                    grep "DDoS" /var/log/syslog | tail -n 10 || echo "No DDoS-related entries found in /var/log/syslog."
                elif [ -f /var/log/messages ]; then
                    grep "DDoS" /var/log/messages | tail -n 10 || echo "No DDoS-related entries found in /var/log/messages."
                else
                    echo "No syslog or messages log found. Your system may not log this information."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

trace_ddos_sources
