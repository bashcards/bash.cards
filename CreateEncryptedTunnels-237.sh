#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Diamonds Card
ten_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                             Ten of Diamonds                             |"
    echo "     |                        Create Encrypted Tunnels                         |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card uses socat to establish encrypted tunnels for secure data    |"
    echo "     |  transfer or communication.                                             |"
    echo "     |                                                                         |"
    echo "     |  1. Create an Encrypted Listener                                        |"
    echo "     |  2. Connect to an Encrypted Listener                                    |"
    echo "     |  3. Test the Encrypted Tunnel                                           |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_encrypted_listener ;;
        2) connect_encrypted_listener ;;
        3) test_encrypted_tunnel ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_diamonds_menu ;;
    esac
}

# Create an Encrypted Listener
create_encrypted_listener() {
    clear
    echo -e "${CYAN}Creating an Encrypted Listener...${RESET}"
    read -p "Enter the port to listen on: " port
    read -p "Enter the path to the private key file: " keyfile
    if [[ -f $keyfile ]]; then
        echo "Starting socat listener on port $port..."
        socat OPENSSL-LISTEN:$port,cert=$keyfile,cafile=$keyfile,reuseaddr -
    else
        echo "Error: Key file not found at $keyfile."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Connect to an Encrypted Listener
connect_encrypted_listener() {
    clear
    echo -e "${CYAN}Connecting to an Encrypted Listener...${RESET}"
    read -p "Enter the host to connect to: " host
    read -p "Enter the port to connect on: " port
    read -p "Enter the path to the private key file: " keyfile
    if [[ -f $keyfile ]]; then
        echo "Connecting to $host on port $port..."
        socat OPENSSL:$host:$port,cert=$keyfile,cafile=$keyfile -
    else
        echo "Error: Key file not found at $keyfile."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Test the Encrypted Tunnel
test_encrypted_tunnel() {
    clear
    echo -e "${CYAN}Testing the Encrypted Tunnel...${RESET}"
    read -p "Enter the host to connect to: " host
    read -p "Enter the port to connect on: " port
    if command -v curl &>/dev/null; then
        echo "Testing with curl..."
        curl -k https://$host:$port
    else
        echo "Error: curl is not installed."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

ten_of_diamonds_menu
