#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ace of Spades Card
ace_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ace of Spades                              |"
    echo "     |                      Generate AV-Evading Payloads                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an interface to generate payloads that evade        |"
    echo "     |  antivirus detection using Veil.                                        |"
    echo "     |                                                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Generate a payload                                                  |"
    echo "     |  2. List available payloads                                             |"
    echo "     |  3. View Veil documentation                                             |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) generate_payload ;;
        2) list_payloads ;;
        3) view_documentation ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_spades_menu ;;
    esac
}

# Generate a payload
generate_payload() {
    clear
    echo -e "${CYAN}Generating a payload...${RESET}"
    if command -v veil &>/dev/null; then
        veil
    else
        echo -e "${CYAN}Error: Veil is not installed.${RESET}"
        echo "Please install Veil by following the instructions at https://www.veil-framework.com/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

# List available payloads
list_payloads() {
    clear
    echo -e "${CYAN}Listing available payloads...${RESET}"
    if command -v veil &>/dev/null; then
        veil -l
    else
        echo -e "${CYAN}Error: Veil is not installed.${RESET}"
        echo "Please install Veil by following the instructions at https://www.veil-framework.com/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

# View Veil documentation
view_documentation() {
    clear
    echo -e "${CYAN}Viewing Veil documentation...${RESET}"
    if command -v xdg-open &>/dev/null; then
        xdg-open "https://www.veil-framework.com/documentation/"
    else
        echo -e "${CYAN}Please visit: https://www.veil-framework.com/documentation/${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_spades_menu
}

ace_of_spades_menu
