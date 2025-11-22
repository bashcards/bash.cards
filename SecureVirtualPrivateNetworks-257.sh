#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Three of Clubs Card
three_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Three of Clubs                             |"
    echo "     |                   Set Up Secure Virtual Private Networks                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to configure, connect, and verify secure VPNs.|"
    echo "     |                                                                         |"
    echo "     |  1. Configure VPN Client                                                |"
    echo "     |  2. Connect to VPN                                                      |"
    echo "     |  3. Verify VPN Connection                                               |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) configure_vpn ;;
        2) connect_to_vpn ;;
        3) verify_vpn ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_clubs_menu ;;
    esac
}

# Configure VPN Client
configure_vpn() {
    clear
    echo -e "${CYAN}Configuring VPN Client...${RESET}"
    if command -v openvpn &>/dev/null; then
        read -p "Enter the path to your VPN configuration file (e.g., .ovpn): " vpn_config
        if [[ -f "$vpn_config" ]]; then
            echo "Configuration file found. You can now use this file to connect."
        else
            echo "Error: Configuration file not found. Please provide a valid path."
        fi
    else
        echo -e "${CYAN}Error: openvpn is not installed.${RESET}"
        echo "Please install OpenVPN using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

# Connect to VPN
connect_to_vpn() {
    clear
    echo -e "${CYAN}Connecting to VPN...${RESET}"
    if command -v openvpn &>/dev/null; then
        read -p "Enter the path to your VPN configuration file (e.g., .ovpn): " vpn_config
        if [[ -f "$vpn_config" ]]; then
            sudo openvpn --config "$vpn_config"
        else
            echo "Error: Configuration file not found. Please provide a valid path."
        fi
    else
        echo -e "${CYAN}Error: openvpn is not installed.${RESET}"
        echo "Please install OpenVPN using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

# Verify VPN Connection
verify_vpn() {
    clear
    echo -e "${CYAN}Verifying VPN Connection...${RESET}"
    if command -v curl &>/dev/null; then
        public_ip=$(curl -s https://ipinfo.io/ip)
        echo "Your public IP address is: $public_ip"
        echo "If the IP address matches your VPN provider, the connection is successful."
    else
        echo -e "${CYAN}Error: curl is not installed.${RESET}"
        echo "Please install curl using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

three_of_clubs_menu
