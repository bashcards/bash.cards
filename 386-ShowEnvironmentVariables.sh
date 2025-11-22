#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Clubs Card
ten_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ten of Clubs                               |"
    echo "     |                       Show Environment Variables                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card lets you view, filter, and modify environment variables.     |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Show All Environment Variables                                      |"
    echo "     |  2. Filter Environment Variables by Name                                |"
    echo "     |  3. Add or Modify an Environment Variable                               |"
    echo "     |  4. Remove an Environment Variable                                      |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) show_all_env ;;
        2) filter_env ;;
        3) add_modify_env ;;
        4) remove_env ;;
        5) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; ten_of_clubs_menu ;;
    esac
}

# Option 1: Show All Environment Variables
show_all_env() {
    clear
    echo -e "${CYAN}All Environment Variables:${RESET}"
    env | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Option 2: Filter Environment Variables by Name
filter_env() {
    clear
    read -p "Enter a keyword to filter environment variables: " keyword
    clear
    echo -e "${CYAN}Filtered Environment Variables (${keyword}):${RESET}"
    env | grep "$keyword"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Option 3: Add or Modify an Environment Variable
add_modify_env() {
    clear
    read -p "Enter the name of the environment variable: " var_name
    read -p "Enter the value for $var_name: " var_value
    export "$var_name=$var_value"
    echo -e "${CYAN}Environment variable $var_name set to $var_value.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Option 4: Remove an Environment Variable
remove_env() {
    clear
    read -p "Enter the name of the environment variable to remove: " var_name
    unset "$var_name"
    echo -e "${CYAN}Environment variable $var_name removed.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Option 5: Exit Script
exit_script() {
    clear
    exit 0
}

ten_of_clubs_menu
