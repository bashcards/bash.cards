#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ace of Clubs Card
ace_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ace of Clubs                                |"
    echo "     |                     Spoof MAC Addresses for Anonymity                    |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to use macchanger to spoof MAC addresses on        |"
    echo "     |  your network interfaces, enhancing anonymity and bypassing restrictions.|"
    echo "     |                                                                          |"
    echo "     |  1. View Current MAC Address                                             |"
    echo "     |  2. Change MAC Address (Random)                                          |"
    echo "     |  3. Reset to Original MAC Address                                        |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_mac ;;
        2) change_mac ;;
        3) reset_mac ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_clubs_menu ;;
    esac
}

# View the current MAC address
view_mac() {
    clear
    echo -e "${CYAN}View Current MAC Address${RESET}"
    read -p "Enter the network interface (e.g., eth0, wlan0): " interface
    if [[ -n "$interface" ]]; then
        ip link show "$interface" | grep "link/ether" || echo "Interface not found or MAC address unavailable."
    else
        echo "Error: No interface provided."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_clubs_menu
}

# Change MAC address to a random one
change_mac() {
    clear
    echo -e "${CYAN}Change MAC Address (Random)${RESET}"
    read -p "Enter the network interface (e.g., eth0, wlan0): " interface
    if command -v macchanger &>/dev/null; then
        if [[ -n "$interface" ]]; then
            sudo macchanger -r "$interface" && echo -e "${CYAN}MAC address changed successfully.${RESET}"
        else
            echo "Error: No interface provided."
        fi
    else
        echo -e "${CYAN}Error: macchanger is not installed.${RESET}"
        echo "Please install macchanger using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_clubs_menu
}

# Reset to original MAC address
reset_mac() {
    clear
    echo -e "${CYAN}Reset to Original MAC Address${RESET}"
    read -p "Enter the network interface (e.g., eth0, wlan0): " interface
    if command -v macchanger &>/dev/null; then
        if [[ -n "$interface" ]]; then
            sudo macchanger -p "$interface" && echo -e "${CYAN}MAC address reset successfully.${RESET}"
        else
            echo "Error: No interface provided."
        fi
    else
        echo -e "${CYAN}Error: macchanger is not installed.${RESET}"
        echo "Please install macchanger using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_clubs_menu
}

ace_of_clubs_menu
