#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the King of Clubs Card
king_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              King of Clubs                               |"
    echo "     |                    Access Highly Secure VPN Services                     |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card enables you to set up and manage secure VPN connections       |"
    echo "     |  using AirVPN, ensuring anonymity and encrypted communications.          |"
    echo "     |                                                                         |"
    echo "     |  1. Connect to AirVPN                                                   |"
    echo "     |  2. Disconnect from AirVPN                                              |"
    echo "     |  3. Check VPN Connection Status                                         |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) connect_airvpn ;;
        2) disconnect_airvpn ;;
        3) check_vpn_status ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_clubs_menu ;;
    esac
}

# Connect to AirVPN
connect_airvpn() {
    clear
    echo -e "${CYAN}Connecting to AirVPN...${RESET}"
    read -p "Enter your AirVPN configuration file path (e.g., airvpn.ovpn): " config_file
    if [ -f "$config_file" ]; then
        if command -v openvpn &>/dev/null; then
            sudo openvpn --config "$config_file" &
            echo "AirVPN connection initiated. Check the status for confirmation."
        else
            echo "Error: openvpn is not installed. Please install it to connect to AirVPN."
        fi
    else
        echo "Error: Configuration file $config_file not found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Disconnect from AirVPN
disconnect_airvpn() {
    clear
    echo -e "${CYAN}Disconnecting from AirVPN...${RESET}"
    if pgrep openvpn &>/dev/null; then
        sudo pkill openvpn
        echo "Disconnected from AirVPN."
    else
        echo "No active VPN connection found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

# Check VPN Connection Status
check_vpn_status() {
    clear
    echo -e "${CYAN}Checking VPN connection status...${RESET}"
    if pgrep openvpn &>/dev/null; then
        echo "AirVPN is connected."
    else
        echo "No active VPN connection detected."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_clubs_menu
}

king_of_clubs_menu
