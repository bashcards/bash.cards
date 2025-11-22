#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Five of Hearts Card
five_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Five of Hearts                              |"
    echo "     |                        Manage and Explore Hostnames                      |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card enables hostname management and exploration with advanced     |"
    echo "     |  features like network analysis and connectivity checks.                 |"
    echo "     |                                                                          |"
    echo "     |  1. Display Current Hostname                                             |"
    echo "     |  2. Change Hostname                                                      |"
    echo "     |  3. Display Fully Qualified Domain Name (FQDN)                           |"
    echo "     |  4. List Local Network Devices and their Hostnames                       |"
    echo "     |  5. Test Connectivity with Hostname                                      |"
    echo "     |  6. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) display_hostname ;;
        2) change_hostname ;;
        3) display_fqdn ;;
        4) list_network_devices ;;
        5) test_connectivity ;;
        6) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; five_of_hearts_menu ;;
    esac
}

# Display the hostname of the system
display_hostname() {
    clear
    echo -e "${CYAN}System Hostname:${RESET} $(hostname)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# Change the hostname of the system
change_hostname() {
    clear
    read -p "Enter the new hostname: " new_hostname
    if [[ -z $new_hostname ]]; then
        echo -e "${RED}Hostname cannot be empty.${RESET}"
    else
        sudo hostnamectl set-hostname "$new_hostname"
        echo -e "${CYAN}Hostname changed to '${new_hostname}'.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# Display the Fully Qualified Domain Name (FQDN)
display_fqdn() {
    clear
    echo -e "${CYAN}Fully Qualified Domain Name (FQDN):${RESET} $(hostname -f)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# List all network devices and their hostnames
list_network_devices() {
    clear
    echo -e "${CYAN}Listing local network devices and their hostnames:${RESET}"
    arp -a
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

# Test connectivity with a hostname
test_connectivity() {
    clear
    read -p "Enter a hostname to test connectivity (e.g., google.com): " target_hostname
    if ping -c 3 "$target_hostname" &>/dev/null; then
        echo -e "${GREEN}Connection successful to $target_hostname.${RESET}"
    else
        echo -e "${RED}Failed to connect to $target_hostname.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_hearts_menu
}

five_of_hearts_menu
