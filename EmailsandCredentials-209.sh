#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Three of Hearts Card
three_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Three of Hearts                            |"
    echo "     |                       Harvest Emails and Credentials                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an interface to use tools for gathering email       |"
    echo "     |  addresses, credentials, and other publicly available information.      |"
    echo "     |                                                                         |"
    echo "     |                                                                         |"
    echo "     |  1. Perform Harvesting with theHarvester                                |"
    echo "     |  2. Save Results to File                                                |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) perform_harvesting ;;
        2) save_results ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_hearts_menu ;;
    esac
}

# Perform Harvesting with theHarvester
perform_harvesting() {
    clear
    echo -e "${CYAN}Performing Harvesting with theHarvester...${RESET}"
    if command -v theharvester &>/dev/null; then
        echo "Enter the domain to target (e.g., example.com):"
        read -p "> " domain
        echo "Enter the source (e.g., google, bing, linkedin):"
        read -p "> " source
        echo -e "${CYAN}Running theHarvester for domain $domain using source $source...${RESET}"
        theharvester -d "$domain" -b "$source" | tee harvester_results.txt
        echo -e "${CYAN}Results saved to harvester_results.txt.${RESET}"
    else
        echo -e "${CYAN}Error: theHarvester is not installed.${RESET}"
        echo "Please install it with: sudo apt install theharvester."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

# Save Results to File
save_results() {
    clear
    echo -e "${CYAN}Save Results to File${RESET}"
    if [[ -f "harvester_results.txt" ]]; then
        echo "Enter the path to save the results file:"
        read -p "> " save_path
        cp harvester_results.txt "$save_path"
        echo -e "${CYAN}Results saved to $save_path.${RESET}"
    else
        echo -e "${CYAN}Error: No results file found. Please run harvesting first.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

three_of_hearts_menu
