#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Clubs Card
queen_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Queen of Clubs                             |"
    echo "     |                   Remove an Environment Variable Safely                 |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to remove an environment variable from your       |"
    echo "     |  current session using the 'unset' command. This is useful for          |"
    echo "     |  managing temporary or unused environment variables.                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. List Current Environment Variables                                  |"
    echo "     |  2. Remove an Environment Variable                                      |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) list_variables ;;
        2) remove_variable ;;
        3) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; queen_of_clubs_menu ;;
    esac
}

# Option 1: List Current Environment Variables
list_variables() {
    clear
    echo -e "${CYAN}Current Environment Variables:${RESET}"
    env | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_clubs_menu
}

# Option 2: Remove an Environment Variable
remove_variable() {
    clear
    echo "Select an environment variable to unset:"
    vars=($(env | cut -d= -f1))
    vars+=("Cancel")
    select var in "${vars[@]}"; do
        case $var in
            "Cancel")
                queen_of_clubs_menu
                ;;
            *)
                if [[ -n $var ]]; then
                    unset "$var"
                    echo -e "${CYAN}Environment variable '$var' has been removed.${RESET}"
                fi
                break
                ;;
        esac
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_clubs_menu
}

# Option 3: Exit Script
exit_script() {
    clear
    exit 0
}

queen_of_clubs_menu
