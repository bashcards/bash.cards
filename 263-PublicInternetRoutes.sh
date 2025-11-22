#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Clubs Card
nine_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                               Nine of Clubs                             |"
    echo "     |                 Switch Back to Public Internet Routes                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card enables you to safely exit anonymity networks or tunnels     |"
    echo "     |  and return to public (clearnet) internet routes.                       |"
    echo "     |                                                                         |"
    echo "     |  1. Disable Tor Proxy                                                   |"
    echo "     |  2. Disconnect VPN                                                      |"
    echo "     |  3. Reconfigure DNS to Default                                          |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) disable_tor_proxy ;;
        2) disconnect_vpn ;;
        3) reset_dns ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_clubs_menu ;;
    esac
}

# Disable Tor Proxy
disable_tor_proxy() {
    clear
    echo -e "${CYAN}Disabling Tor proxy...${RESET}"
    if command -v tor &>/dev/null; then
        sudo systemctl stop tor
        echo "Tor proxy disabled."
    else
        echo "Error: Tor is not installed or running."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_clubs_menu
}

# Disconnect VPN
disconnect_vpn() {
    clear
    echo -e "${CYAN}Disconnecting VPN...${RESET}"
    if command -v nmcli &>/dev/null; then
        nmcli connection down "$(nmcli connection show --active | grep vpn | awk '{print $1}')"
        echo "VPN disconnected."
    else
        echo "Error: Network Manager (nmcli) is not available."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_clubs_menu
}

# Reconfigure DNS to Default
reset_dns() {
    clear
    echo -e "${CYAN}Resetting DNS settings to default...${RESET}"
    if [[ -f /etc/resolv.conf ]]; then
        echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf > /dev/null
        echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf > /dev/null
        echo "DNS settings reset to default (Cloudflare and Google DNS)."
    else
        echo "Error: Unable to locate /etc/resolv.conf."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_clubs_menu
}

nine_of_clubs_menu
