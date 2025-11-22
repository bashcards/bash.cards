#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Four of Spades Card
four_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Four of Spades                             |"
    echo "     |                 Manage Beacon Implants and Campaigns (Cobalt Strike)    |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides an interface to manage beacon implants and          |"
    echo "     |  orchestrate campaigns using the Cobalt Strike framework.               |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Start Cobalt Strike server                                           |"
    echo "     |  2. Connect to an active server                                         |"
    echo "     |  3. Manage beacons                                                      |"
    echo "     |  4. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_cobaltstrike_server ;;
        2) connect_to_server ;;
        3) manage_beacons ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; four_of_spades_menu ;;
    esac
}

# Start Cobalt Strike server
start_cobaltstrike_server() {
    clear
    echo -e "${CYAN}Starting Cobalt Strike server...${RESET}"
    if [[ -f ./teamserver ]]; then
        read -p "Enter server IP address: " server_ip
        read -p "Enter team server password: " password
        ./teamserver "$server_ip" "$password" &
        echo "Cobalt Strike server started on $server_ip."
    else
        echo -e "${CYAN}Error: Cobalt Strike's teamserver script not found.${RESET}"
        echo "Ensure the script is in the current directory."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

# Connect to an active server
connect_to_server() {
    clear
    echo -e "${CYAN}Connecting to a Cobalt Strike server...${RESET}"
    read -p "Enter server IP address: " server_ip
    read -p "Enter team server password: " password
    if [[ -f ./cobaltstrike-client ]]; then
        ./cobaltstrike-client "$server_ip" "$password"
    else
        echo -e "${CYAN}Error: Cobalt Strike client script not found.${RESET}"
        echo "Ensure the client is in the current directory."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

# Manage beacons
manage_beacons() {
    clear
    echo -e "${CYAN}Managing beacons...${RESET}"

    if [[ -f ./cs_console ]]; then
        read -p "Enter server IP address: " server_ip
        read -p "Enter console password: " console_password
        echo -e "Connecting to the server to retrieve active beacons..."
        ./cs_console "$server_ip" "$console_password" "beacon_list" > beacons.txt
        if [[ -s beacons.txt ]]; then
            echo "Active beacons:"
            cat beacons.txt
            echo "Enter the beacon ID to interact with:"
            read beacon_id
            ./cs_console "$server_ip" "$console_password" "interact $beacon_id"
        else
            echo "No active beacons found."
        fi
    else
        echo -e "${CYAN}Error: Cobalt Strike console script not found.${RESET}"
        echo "Ensure the script is in the current directory."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_spades_menu
}

four_of_spades_menu
