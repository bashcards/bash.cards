#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

kill_malicious_processes() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "      __________________________________________________________________________"
        echo "     |                               Three of Hearts                            |"
        echo "     |                          Kill Malicious Processes                        |"
        echo "     |__________________________________________________________________________|"
        echo "     |                                                                          |"
        echo "     |  Select an option to identify and kill malicious processes:              |"
        echo "     |                                                                          |"
        echo "     |  1. List all running processes                                           |"
        echo "     |  2. Find processes consuming high CPU or memory                          |"
        echo "     |  3. Kill a process by PID                                                |"
        echo "     |  4. Search and kill a process by name                                    |"
        echo "     |  5. Exit                                                                 |"
        echo "     |__________________________________________________________________________|"
        echo "     |                                                                          |"
        echo "     |                            Enter your choice:                            |"
        echo "     |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing all running processes...${RESET}"
                ps aux --sort=-%cpu,-%mem | less
                ;;
            2)
                clear
                echo -e "${CYAN}Processes consuming high CPU or memory:${RESET}"
                ps aux --sort=-%cpu,-%mem | head -n 15
                ;;
            3)
                clear
                read -p "Enter the PID of the process to kill: " pid
                if [[ "$pid" =~ ^[0-9]+$ ]]; then
                    if kill -9 "$pid" 2>/dev/null; then
                        echo -e "${CYAN}Process with PID $pid has been terminated.${RESET}"
                    else
                        echo -e "${CYAN}Failed to kill process with PID $pid. Ensure you have the correct permissions.${RESET}"
                    fi
                else
                    echo -e "${CYAN}Invalid PID. Returning to menu...${RESET}"
                fi
                ;;
            4)
                clear
                read -p "Enter the name of the process to search and kill: " proc_name
                if [ -n "$proc_name" ]; then
                    matching_pids=$(pgrep "$proc_name")
                    if [ -z "$matching_pids" ]; then
                        echo -e "${CYAN}No processes found with the name \"$proc_name\".${RESET}"
                    else
                        echo -e "${CYAN}Found the following processes:${RESET}"
                        ps aux | grep "$proc_name" | grep -v grep
                        read -p "Kill all matching processes? (y/n): " kill_choice
                        if [[ "$kill_choice" =~ ^[Yy]$ ]]; then
                            pkill "$proc_name"
                            echo -e "${CYAN}All processes with the name \"$proc_name\" have been terminated.${RESET}"
                        else
                            echo -e "${CYAN}No processes were terminated.${RESET}"
                        fi
                    fi
                else
                    echo -e "${CYAN}No process name entered. Returning to menu...${RESET}"
                fi
                ;;
            5)
                clear
                echo -e "${CYAN}Exiting...${RESET}"
                exit 0
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the main menu...${RESET}"
        read -n 1 -s -r
    done
}

kill_malicious_processes
