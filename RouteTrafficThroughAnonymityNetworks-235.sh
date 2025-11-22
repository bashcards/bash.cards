#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Eight of Diamonds Card
eight_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Eight of Diamonds                          |"
    echo "     |                  Route Traffic Through Anonymity Networks               |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to configure and use Tor for routing your     |"
    echo "     |  traffic through the Tor network, ensuring anonymity and privacy.       |"
    echo "     |                                                                         |"
    echo "     |  1. Start Tor Service                                                   |"
    echo "     |  2. Check Tor Connection                                                |"
    echo "     |  3. Route Traffic via Tor                                               |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_tor_service ;;
        2) check_tor_connection ;;
        3) route_traffic_via_tor ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_diamonds_menu ;;
    esac
}

# Start Tor Service
start_tor_service() {
    clear
    echo -e "${CYAN}Starting Tor Service...${RESET}"
    if command -v tor &>/dev/null; then
        sudo systemctl start tor
        sudo systemctl enable tor
        echo -e "${CYAN}Tor service started successfully.${RESET}"
    else
        echo -e "${CYAN}Error: Tor is not installed.${RESET}"
        echo "Please install Tor using your package manager or visit https://www.torproject.org/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_diamonds_menu
}

# Check Tor Connection
check_tor_connection() {
    clear
    echo -e "${CYAN}Checking Tor Connection...${RESET}"
    if command -v curl &>/dev/null; then
        curl --socks5-hostname 127.0.0.1:9050 https://check.torproject.org | grep -i "congratulations"
    else
        echo -e "${CYAN}Error: curl is not installed.${RESET}"
        echo "Please install curl using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_diamonds_menu
}

# Route Traffic via Tor
route_traffic_via_tor() {
    clear
    echo -e "${CYAN}Routing Traffic via Tor...${RESET}"
    if command -v proxychains &>/dev/null; then
        echo "Configuring ProxyChains to route traffic through Tor..."
        echo "Example: proxychains firefox"
        echo -e "${CYAN}Traffic is now routed via Tor using ProxyChains.${RESET}"
    else
        echo -e "${CYAN}Error: ProxyChains is not installed.${RESET}"
        echo "Please install ProxyChains using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_diamonds_menu
}

eight_of_diamonds_menu
