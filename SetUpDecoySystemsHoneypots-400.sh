#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

setup_honeypot() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________"
        echo "    |                Nine of Hearts             |"
        echo "    |       Set Up Decoy Systems (Honeypots)    |"
        echo "    |___________________________________________|"
        echo "    |                                           |"
        echo "    |  1. Emulate SSH honeypot                  |"
        echo "    |  2. Set up HTTP honeypot                  |"
        echo "    |  3. Deploy custom port listener           |"
        echo "    |  4. Analyze honeypot logs                 |"
        echo "    |  5. Exit                                  |"
        echo "    |___________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Emulating an SSH honeypot...${RESET}"
                read -p "Enter port to listen on (default: 2222): " ssh_port
                ssh_port=${ssh_port:-2222}
                echo -e "${CYAN}Listening on port $ssh_port. Logs saved to honeypot_ssh.log.${RESET}"
                while true; do
                    echo "Unauthorized access attempt on port $ssh_port" >> honeypot_ssh.log
                    nc -lvp "$ssh_port" > /dev/null
                done &
                ;;
            2)
                clear
                echo -e "${CYAN}Setting up a simple HTTP honeypot...${RESET}"
                read -p "Enter port to listen on (default: 8080): " http_port
                http_port=${http_port:-8080}
                echo -e "${CYAN}Listening on port $http_port. Logs saved to honeypot_http.log.${RESET}"
                while true; do
                    echo -e "HTTP/1.1 200 OK\n\nWelcome to the decoy server!" | nc -lvp "$http_port" >> honeypot_http.log
                done &
                ;;
            3)
                clear
                echo -e "${CYAN}Deploying a custom port listener honeypot...${RESET}"
                read -p "Enter port to listen on: " custom_port
                echo -e "${CYAN}Listening on port $custom_port. Logs saved to honeypot_custom.log.${RESET}"
                while true; do
                    nc -lvp "$custom_port" >> honeypot_custom.log
                done &
                ;;
            4)
                clear
                echo -e "${CYAN}Analyzing honeypot logs...${RESET}"
                if ls honeypot_*.log 1>/dev/null 2>&1; then
                    for log_file in honeypot_*.log; do
                        echo -e "${CYAN}--- Contents of $log_file ---${RESET}"
                        tail -n 20 "$log_file" | less
                    done
                else
                    echo -e "${CYAN}No honeypot logs found.${RESET}"
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

setup_honeypot
