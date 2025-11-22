#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Hearts Card
nine_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Nine of Hearts                              |"
    echo "     |                          Map DNS Infrastructure                          |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card utilizes dnsrecon to map DNS infrastructure and perform       |"
    echo "     |  reconnaissance on DNS records, helping to uncover critical DNS data.    |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Perform a standard DNS reconnaissance                                |"
    echo "     |  2. Perform zone transfer tests                                          |"
    echo "     |  3. Save results to a file                                               |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) standard_dns_recon ;;
        2) zone_transfer_test ;;
        3) save_results ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_hearts_menu ;;
    esac
}

# Perform standard DNS reconnaissance
standard_dns_recon() {
    clear
    echo -e "${CYAN}Starting standard DNS reconnaissance...${RESET}"
    if command -v dnsrecon &>/dev/null; then
        read -p "Enter the domain to scan: " domain
        dnsrecon -d "$domain"
    else
        echo -e "${CYAN}Error: dnsrecon is not installed.${RESET}"
        echo "Please install dnsrecon using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

# Perform zone transfer tests
zone_transfer_test() {
    clear
    echo -e "${CYAN}Performing zone transfer test...${RESET}"
    if command -v dnsrecon &>/dev/null; then
        read -p "Enter the domain to test: " domain
        dnsrecon -d "$domain" -t axfr
    else
        echo -e "${CYAN}Error: dnsrecon is not installed.${RESET}"
        echo "Please install dnsrecon using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

# Save results to a file
save_results() {
    clear
    echo -e "${CYAN}Saving results...${RESET}"
    if command -v dnsrecon &>/dev/null; then
        read -p "Enter the domain to scan: " domain
        read -p "Enter the filename to save results (e.g., results.txt): " filename
        dnsrecon -d "$domain" > "$filename"
        echo -e "${CYAN}Results saved to $filename.${RESET}"
    else
        echo -e "${CYAN}Error: dnsrecon is not installed.${RESET}"
        echo "Please install dnsrecon using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_hearts_menu
}

nine_of_hearts_menu
