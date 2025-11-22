#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ace of Hearts Card
ace_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ace of Hearts                              |"
    echo "     |                        Intercept and Analyze Traffic                    |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides a lightweight interface for intercepting and         |"
    echo "     |  analyzing HTTP, HTTPS, and WebSocket traffic using mitmproxy.           |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Start mitmproxy in interactive mode                                  |"
    echo "     |  2. Save intercepted traffic to a file                                  |"
    echo "     |  3. View previously saved traffic logs                                  |"
    echo "     |  4. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_mitmproxy ;;
        2) save_traffic ;;
        3) view_logs ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_hearts_menu ;;
    esac
}

# Start mitmproxy in interactive mode
start_mitmproxy() {
    clear
    echo -e "${CYAN}Starting mitmproxy in interactive mode...${RESET}"
    if command -v mitmproxy &>/dev/null; then
        mitmproxy
    else
        echo -e "${CYAN}Error: mitmproxy is not installed.${RESET}"
        echo "Please install mitmproxy using your package manager or visit https://mitmproxy.org/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# Save intercepted traffic to a file
save_traffic() {
    clear
    echo -e "${CYAN}Saving intercepted traffic...${RESET}"
    if command -v mitmdump &>/dev/null; then
        read -p "Enter the filename to save the traffic (e.g., traffic.log): " filename
        mitmdump -w "$filename"
        echo -e "${CYAN}Traffic saved to $filename.${RESET}"
    else
        echo -e "${CYAN}Error: mitmdump is not installed.${RESET}"
        echo "Please install mitmproxy using your package manager or visit https://mitmproxy.org/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

# View previously saved traffic logs
view_logs() {
    clear
    echo -e "${CYAN}Viewing traffic logs...${RESET}"
    read -p "Enter the filename of the traffic log to view: " filename
    if [[ -f "$filename" ]]; then
        less "$filename"
    else
        echo -e "${CYAN}Error: File $filename not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ace_of_hearts_menu
}

ace_of_hearts_menu
