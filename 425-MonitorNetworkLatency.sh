#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

monitor_network_latency() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |             Eight of Spades               |"
        echo "    | Monitor Network Latency for Abnormalities |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Perform ICMP Latency Test             |"
        echo "    |  2. Analyze Latency Trends Over Time      |"
        echo "    |  3. Monitor Real-Time Latency with ping   |"
        echo "    |  4. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Performing ICMP latency test to known hosts...${RESET}"
                echo -e "Checking latency to 8.8.8.8 (Google DNS)...\n"
                ping -c 5 8.8.8.8
                echo -e "${CYAN}Test complete. Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            2)
                clear
                echo -e "${CYAN}Analyzing latency trends over time...${RESET}"
                echo -e "This will monitor 8.8.8.8 for 60 seconds and display results.\n"
                ping -i 1 -c 60 8.8.8.8 | awk '/time=/{split($7,a,"="); sum+=a[2]; count++} END {print "Average Latency:", sum/count, "ms"}'
                echo -e "${CYAN}Trend analysis complete. Press any key to continue...${RESET}"
                read -n 1 -s
                ;;
            3)
                clear
                echo -e "${CYAN}Monitoring real-time latency to multiple targets...${RESET}"
                echo -e "Press Ctrl+C to stop.\n"
                watch -n 1 'ping -c 1 8.8.8.8 | grep "time="'
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

monitor_network_latency
