#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

track_unusual_behavior() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |              Seven of Diamonds            |"
        echo "    |       Track Unusual System Behavior       |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Detect spikes in CPU and memory usage |"
        echo "    |  2. Identify new processes                |"
        echo "    |  3. Monitor unusual disk activity         |"
        echo "    |  4. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Analyzing CPU and memory usage...${RESET}"
                echo -e "${CYAN}Processes consuming the most resources:${RESET}"
                ps aux --sort=-%cpu,-%mem | head -n 10
                echo -e "${CYAN}Displayed top resource-consuming processes.${RESET}"
                ;;
            2)
                clear
                echo -e "${CYAN}Identifying new processes...${RESET}"
                echo -e "${CYAN}Current processes not seen before:${RESET}"
                if [ ! -f "/tmp/previous_processes.log" ]; then
                    ps -eo pid,command > /tmp/previous_processes.log
                    echo "Baseline of current processes saved. Run this option again to detect changes."
                else
                    current_processes=$(mktemp)
                    ps -eo pid,command > "$current_processes"
                    comm -13 <(sort /tmp/previous_processes.log) <(sort "$current_processes")
                    mv "$current_processes" /tmp/previous_processes.log
                fi
                ;;
            3)
                clear
                echo -e "${CYAN}Monitoring unusual disk activity...${RESET}"
                echo -e "${CYAN}Recent write-heavy processes:${RESET}"
                iotop -botqqq | grep -E "WRITE|DISK" | head -n 10 || echo -e "${CYAN}No recent heavy disk activity detected.${RESET}"
                ;;
            4)
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

track_unusual_behavior
