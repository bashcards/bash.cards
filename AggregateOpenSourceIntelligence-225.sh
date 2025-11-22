#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Hearts Card
queen_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                             Queen of Hearts                              |"
    echo "     |                 Aggregate Open-Source Intelligence (OSINT)               |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card uses OSINT Framework for aggregating various open-source      |"
    echo "     |  intelligence resources, enabling detailed investigations and data       |"
    echo "     |  gathering.                                                              |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Launch OSINT Framework                                               |"
    echo "     |  2. Search for a specific target                                         |"
    echo "     |  3. View saved OSINT results                                             |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) launch_osint_framework ;;
        2) search_target ;;
        3) view_osint_results ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_hearts_menu ;;
    esac
}

# Launch OSINT Framework
launch_osint_framework() {
    clear
    echo -e "${CYAN}Launching OSINT Framework...${RESET}"
    if command -v osintframework &>/dev/null; then
        osintframework
    else
        echo -e "${CYAN}Error: OSINT Framework is not installed.${RESET}"
        echo "Please visit https://osintframework.com/ to learn more or integrate the tool into your environment."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

# Search for a specific target
search_target() {
    clear
    echo -e "${CYAN}Search for a specific target using OSINT Framework...${RESET}"
    read -p "Enter the target (e.g., domain, email, username): " target
    if command -v osintframework &>/dev/null; then
        osintframework --search "$target"
    else
        echo -e "${CYAN}Error: OSINT Framework is not installed.${RESET}"
        echo "Please visit https://osintframework.com/ to learn more or integrate the tool into your environment."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

# View saved OSINT results
view_osint_results() {
    clear
    echo -e "${CYAN}Viewing saved OSINT results...${RESET}"
    results_path="$HOME/osint_results"
    if [[ -d "$results_path" ]]; then
        ls "$results_path"
        read -p "Enter the filename to view (or type 'cancel' to return): " file_choice
        if [[ $file_choice == "cancel" ]]; then
            echo "Returning to menu..."
        elif [[ -f "$results_path/$file_choice" ]]; then
            less "$results_path/$file_choice"
        else
            echo -e "${CYAN}Error: File $file_choice not found.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: No saved OSINT results directory found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_hearts_menu
}

queen_of_hearts_menu
