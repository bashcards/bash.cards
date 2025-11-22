#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

real_time_intrusion_detection() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ____________________________________________"
        echo "    |               Two of Hearts               |"
        echo "    | Run Real-Time Network Intrusion Detection |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Analyze live network traffic          |"
        echo "    |  2. Review recent intrusion alerts        |"
        echo "    |  3. Inspect Suricata rule sets            |"
        echo "    |  4. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing live network traffic...${RESET}"
                sudo tcpdump -c 50 -i any
                echo -e "${CYAN}Traffic analysis completed. Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            2)
                clear
                echo -e "${CYAN}Reviewing recent intrusion alerts...${RESET}"
                if [ -f /var/log/suricata/fast.log ]; then
                    tail -n 20 /var/log/suricata/fast.log
                else
                    echo -e "${CYAN}No Suricata alert log found. Ensure Suricata is configured.${RESET}"
                fi
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
                ;;
            3)
                clear
                echo -e "${CYAN}Inspecting Suricata rule sets...${RESET}"
                if [ -d /etc/suricata/rules ]; then
                    ls /etc/suricata/rules
                else
                    echo -e "${CYAN}No Suricata rule sets found. Ensure Suricata is installed.${RESET}"
                fi
                echo -e "${CYAN}Press any key to return to the menu...${RESET}"
                read -n 1 -s -r
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

real_time_intrusion_detection
