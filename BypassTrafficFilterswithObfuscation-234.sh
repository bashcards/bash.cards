#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Diamonds Card
seven_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Seven of Diamonds                          |"
    echo "     |                Bypass Traffic Filters with Obfuscation                  |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to use Obfsproxy for bypassing network        |"
    echo "     |  filters and censorship. Obfsproxy obfuscates your traffic to evade     |"
    echo "     |  detection by deep packet inspection (DPI) or other filtering tools.    |"
    echo "     |                                                                         |"
    echo "     |  1. Start Obfsproxy Server                                              |"
    echo "     |  2. Connect to Obfsproxy Server as a Client                             |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_obfsproxy_server ;;
        2) connect_obfsproxy_client ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_diamonds_menu ;;
    esac
}

# Start Obfsproxy Server
start_obfsproxy_server() {
    clear
    echo -e "${CYAN}Starting Obfsproxy Server...${RESET}"
    read -p "Enter the port number to listen on (e.g., 1234): " port
    read -sp "Enter the shared secret for obfuscation: " secret
    echo
    if command -v obfsproxy &>/dev/null; then
        echo -e "${CYAN}Obfsproxy server is starting on port $port...${RESET}"
        obfsproxy obfs4 --log-file=obfsproxy.log --dest=127.0.0.1:$port server --shared-secret="$secret"
    else
        echo -e "${CYAN}Error: Obfsproxy is not installed.${RESET}"
        echo "Please install Obfsproxy using your package manager or check its documentation."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

# Connect to Obfsproxy Server as a Client
connect_obfsproxy_client() {
    clear
    echo -e "${CYAN}Connecting to Obfsproxy Server...${RESET}"
    read -p "Enter the server IP address: " server_ip
    read -p "Enter the port number to connect to: " port
    read -sp "Enter the shared secret for obfuscation: " secret
    echo
    if command -v obfsproxy &>/dev/null; then
        echo -e "${CYAN}Connecting to Obfsproxy server at $server_ip on port $port...${RESET}"
        obfsproxy obfs4 --log-file=obfsproxy.log --dest="$server_ip:$port" client --shared-secret="$secret"
    else
        echo -e "${CYAN}Error: Obfsproxy is not installed.${RESET}"
        echo "Please install Obfsproxy using your package manager or check its documentation."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

seven_of_diamonds_menu
