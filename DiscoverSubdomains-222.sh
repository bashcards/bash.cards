#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Hearts Card
ten_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ten of Hearts                               |"
    echo "     |                          Discover Subdomains                             |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card uses Sublist3r to discover subdomains of a target domain,     |"
    echo "     |  helping identify hidden assets and potential targets for assessment.    |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Perform subdomain discovery                                          |"
    echo "     |  2. Save results to a file                                               |"
    echo "     |  3. View previously saved results                                        |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) discover_subdomains ;;
        2) save_results ;;
        3) view_results ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_hearts_menu ;;
    esac
}

# Perform subdomain discovery
discover_subdomains() {
    clear
    echo -e "${CYAN}Starting subdomain discovery...${RESET}"
    if command -v sublist3r &>/dev/null; then
        read -p "Enter the domain to scan: " domain
        sublist3r -d "$domain"
    else
        echo -e "${CYAN}Error: Sublist3r is not installed.${RESET}"
        echo "Please install Sublist3r using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# Save results to a file
save_results() {
    clear
    echo -e "${CYAN}Saving results...${RESET}"
    if command -v sublist3r &>/dev/null; then
        read -p "Enter the domain to scan: " domain
        read -p "Enter the filename to save results (e.g., subdomains.txt): " filename
        sublist3r -d "$domain" > "$filename"
        echo -e "${CYAN}Results saved to $filename.${RESET}"
    else
        echo -e "${CYAN}Error: Sublist3r is not installed.${RESET}"
        echo "Please install Sublist3r using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

# View previously saved results
view_results() {
    clear
    echo -e "${CYAN}Viewing saved results...${RESET}"
    read -p "Enter the filename of the saved results: " filename
    if [[ -f "$filename" ]]; then
        less "$filename"
    else
        echo -e "${CYAN}Error: File $filename not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_hearts_menu
}

ten_of_hearts_menu
