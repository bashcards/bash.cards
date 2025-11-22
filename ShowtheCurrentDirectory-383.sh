#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Clubs Card
seven_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Seven of Clubs                             |"
    echo "     |                       Show the Current Directory                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to view the current directory path and offers     |"
    echo "     |  additional options to navigate or view more details.                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Show Current Directory Path                                         |"
    echo "     |  2. View Directory Structure                                            |"
    echo "     |  3. Return to Previous Directory                                        |"
    echo "     |  4. Cancel and Return to Menu                                           |"
    echo "     |  5. Exit                                                               |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) show_current_path ;;
        2) view_directory_structure ;;
        3) return_to_previous_directory ;;
        4) cancel_action ;;
        5) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; seven_of_clubs_menu ;;
    esac
}

# Option 1: Show Current Directory Path
show_current_path() {
    clear
    echo -e "${CYAN}Current Directory Path:${RESET}"
    echo "$(pwd)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

# Option 2: View Directory Structure
view_directory_structure() {
    clear
    echo -e "${CYAN}Directory Structure:${RESET}"
    ls -l
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

# Option 3: Return to Previous Directory
return_to_previous_directory() {
    clear
    echo -e "${CYAN}Returning to the previous directory...${RESET}"
    cd - &>/dev/null
    echo "You are now in: $(pwd)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_clubs_menu
}

# Option 4: Cancel and Return to Menu
cancel_action() {
    clear
    echo "Cancelled. Returning to the menu."
    sleep 1
    seven_of_clubs_menu
}

# Option 5: Exit Script
exit_script() {
    clear
    echo "Exiting the script. Goodbye!"
    exit 0
}

seven_of_clubs_menu
