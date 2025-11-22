#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Two of Clubs Card
two_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Two of Clubs                               |"
    echo "     |                    Route Application Traffic Through Tor                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to use torify to route specific application       |"
    echo "     |  traffic through the Tor network for enhanced privacy and anonymity.    |"
    echo "     |                                                                         |"
    echo "     |  1. Check Tor Service Status                                            |"
    echo "     |  2. Route Application Traffic Through Tor                               |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) check_tor_status ;;
        2) route_via_tor ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; two_of_clubs_menu ;;
    esac
}

# Check the status of the Tor service
check_tor_status() {
    clear
    echo -e "${CYAN}Checking Tor Service Status...${RESET}"
    if command -v systemctl &>/dev/null; then
        systemctl status tor || echo -e "${CYAN}Tor service is not running or not installed.${RESET}"
    else
        echo -e "${CYAN}Systemctl not found. Please check your system configuration.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_clubs_menu
}

# Route application traffic through Tor
route_via_tor() {
    clear
    echo -e "${CYAN}Routing Application Traffic Through Tor${RESET}"
    if command -v torify &>/dev/null; then
        read -p "Enter the application to route through Tor (e.g., curl, ssh): " app
        if [[ -n "$app" ]]; then
            echo -e "${CYAN}Starting $app through Tor...${RESET}"
            torify "$app"
        else
            echo "Error: No application specified."
        fi
    else
        echo -e "${CYAN}Error: torify is not installed.${RESET}"
        echo "Please install tor using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_clubs_menu
}

two_of_clubs_menu
