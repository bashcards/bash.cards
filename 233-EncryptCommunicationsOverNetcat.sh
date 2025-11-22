
#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Diamonds Card
six_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Diamonds                            |"
    echo "     |                   Encrypt Communications over Netcat                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card enables secure communication using encrypted Netcat          |"
    echo "     |  (Cryptcat). It supports encrypted client-server communication for      |"
    echo "     |  secure data transfer and chat.                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Start Cryptcat Server                                               |"
    echo "     |  2. Connect to Cryptcat Server as a Client                              |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_server ;;
        2) connect_client ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_diamonds_menu ;;
    esac
}

# Start Cryptcat Server
start_server() {
    clear
    echo -e "${CYAN}Starting Cryptcat Server...${RESET}"
    read -p "Enter the port number to listen on (e.g., 4444): " port
    read -sp "Enter a shared secret for encryption: " secret
    echo
    if command -v cryptcat &>/dev/null; then
        echo -e "${CYAN}Waiting for incoming connections on port $port...${RESET}"
        cryptcat -l -p "$port" -k "$secret"
    else
        echo -e "${CYAN}Error: Cryptcat is not installed.${RESET}"
        echo "Please install cryptcat using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Connect to Cryptcat Server as a Client
connect_client() {
    clear
    echo -e "${CYAN}Connecting to Cryptcat Server...${RESET}"
    read -p "Enter the server IP address: " server_ip
    read -p "Enter the port number to connect to: " port
    read -sp "Enter the shared secret for encryption: " secret
    echo
    if command -v cryptcat &>/dev/null; then
        echo -e "${CYAN}Connecting to $server_ip on port $port...${RESET}"
        cryptcat "$server_ip" "$port" -k "$secret"
    else
        echo -e "${CYAN}Error: Cryptcat is not installed.${RESET}"
        echo "Please install cryptcat using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

six_of_diamonds_menu
