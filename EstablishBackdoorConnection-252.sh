#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Spades Card
jack_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Jack of Spades                              |"
    echo "     |                       Establish Backdoor Connections                     |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides an interface to establish, monitor, and manage       |"
    echo "     |  backdoor connections using Netcat.                                      |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Set Up Listener                                                      |"
    echo "     |  2. Initiate Connection                                                  |"
    echo "     |  3. Monitor Active Connections                                           |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) setup_listener ;;
        2) initiate_connection ;;
        3) monitor_connections ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_spades_menu ;;
    esac
}

# Set up a Netcat listener
setup_listener() {
    clear
    echo -e "${CYAN}Setting up a listener...${RESET}"
    read -p "Enter the listening port (e.g., 4444): " port

    if command -v nc &>/dev/null; then
        echo -e "${CYAN}Listening on port $port. Use Ctrl+C to stop.${RESET}"
        nc -lvkp "$port"
    else
        echo -e "${CYAN}Error: Netcat (nc) is not installed.${RESET}"
        echo "Please install Netcat using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Initiate a Netcat connection
initiate_connection() {
    clear
    echo -e "${CYAN}Initiating connection...${RESET}"
    read -p "Enter the target IP address: " target_ip
    read -p "Enter the target port: " target_port

    if command -v nc &>/dev/null; then
        echo -e "${CYAN}Connecting to $target_ip on port $target_port. Use Ctrl+C to disconnect.${RESET}"
        nc "$target_ip" "$target_port"
    else
        echo -e "${CYAN}Error: Netcat (nc) is not installed.${RESET}"
        echo "Please install Netcat using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

# Monitor active connections
monitor_connections() {
    clear
    echo -e "${CYAN}Monitoring active connections...${RESET}"

    if command -v netstat &>/dev/null; then
        netstat -ant | grep -i 'established'
    else
        echo -e "${CYAN}Error: netstat is not installed.${RESET}"
        echo "Please install net-tools using your package manager."
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_spades_menu
}

jack_of_spades_menu
