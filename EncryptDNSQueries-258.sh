#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Four of Clubs Card
four_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Four of Clubs                              |"
    echo "     |                          Encrypt DNS Queries                            |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card enables the use of DNSCrypt to encrypt DNS queries and       |"
    echo "     |  protect against DNS spoofing or leakage.                               |"
    echo "     |                                                                         |"
    echo "     |  1. Install DNSCrypt-Proxy                                              |"
    echo "     |  2. Start DNSCrypt-Proxy Service                                        |"
    echo "     |  3. Verify DNSCrypt Configuration                                       |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) install_dnscrypt ;;
        2) start_dnscrypt_service ;;
        3) verify_dnscrypt ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; four_of_clubs_menu ;;
    esac
}

# Install DNSCrypt-Proxy
install_dnscrypt() {
    clear
    echo -e "${CYAN}Installing DNSCrypt-Proxy...${RESET}"
    if command -v dnscrypt-proxy &>/dev/null; then
        echo "DNSCrypt-Proxy is already installed."
    else
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y dnscrypt-proxy
        elif command -v yum &>/dev/null; then
            sudo yum install -y dnscrypt-proxy
        elif command -v pacman &>/dev/null; then
            sudo pacman -Syu dnscrypt-proxy
        else
            echo "Error: Package manager not recognized. Install DNSCrypt manually."
        fi
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_clubs_menu
}

# Start DNSCrypt-Proxy Service
start_dnscrypt_service() {
    clear
    echo -e "${CYAN}Starting DNSCrypt-Proxy Service...${RESET}"
    if command -v dnscrypt-proxy &>/dev/null; then
        sudo systemctl enable dnscrypt-proxy
        sudo systemctl start dnscrypt-proxy
        echo "DNSCrypt-Proxy service started successfully."
    else
        echo "Error: DNSCrypt-Proxy is not installed. Please install it first."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_clubs_menu
}

# Verify DNSCrypt Configuration
verify_dnscrypt() {
    clear
    echo -e "${CYAN}Verifying DNSCrypt Configuration...${RESET}"
    if command -v dnscrypt-proxy &>/dev/null; then
        status=$(sudo systemctl is-active dnscrypt-proxy)
        if [[ "$status" == "active" ]]; then
            echo "DNSCrypt-Proxy is running successfully."
            echo "Check your DNS settings to ensure DNSCrypt is used (e.g., resolvectl status)."
        else
            echo "DNSCrypt-Proxy is not running. Start the service and try again."
        fi
    else
        echo "Error: DNSCrypt-Proxy is not installed. Please install it first."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_clubs_menu
}

four_of_clubs_menu
