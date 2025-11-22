#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Diamonds Card
nine_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                             Nine of Diamonds                            |"
    echo "     |                       Redirect Traffic Through Proxies                  |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card configures and utilizes ProxyChains to route traffic through |"
    echo "     |  multiple proxies for enhanced anonymity.                               |"
    echo "     |                                                                         |"
    echo "     |  1. Configure ProxyChains                                               |"
    echo "     |  2. Test ProxyChains                                                    |"
    echo "     |  3. Run a Program via ProxyChains                                       |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) configure_proxychains ;;
        2) test_proxychains ;;
        3) run_program_via_proxychains ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_diamonds_menu ;;
    esac
}

# Configure ProxyChains
configure_proxychains() {
    clear
    echo -e "${CYAN}Configuring ProxyChains...${RESET}"
    if [[ -f /etc/proxychains.conf ]]; then
        sudo nano /etc/proxychains.conf
    else
        echo -e "${CYAN}Error: ProxyChains configuration file not found.${RESET}"
        echo "Please ensure ProxyChains is installed and properly configured."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

# Test ProxyChains
test_proxychains() {
    clear
    echo -e "${CYAN}Testing ProxyChains...${RESET}"
    if command -v proxychains &>/dev/null; then
        echo "Running test with ProxyChains (e.g., curl through proxies)..."
        proxychains curl https://check.torproject.org | grep -i "congratulations" || echo "ProxyChains test failed. Check configuration."
    else
        echo -e "${CYAN}Error: ProxyChains is not installed.${RESET}"
        echo "Please install ProxyChains using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

# Run a Program via ProxyChains
run_program_via_proxychains() {
    clear
    echo -e "${CYAN}Run a Program via ProxyChains...${RESET}"
    if command -v proxychains &>/dev/null; then
        read -p "Enter the program/command to run through ProxyChains: " program
        proxychains $program
    else
        echo -e "${CYAN}Error: ProxyChains is not installed.${RESET}"
        echo "Please install ProxyChains using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

nine_of_diamonds_menu
