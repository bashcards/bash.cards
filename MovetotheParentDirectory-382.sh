#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Clubs Card
six_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Clubs                               |"
    echo "     |                      Move to the Parent Directory                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to move to the parent directory of your current   |"
    echo "     |  location. You can also view the current directory structure or choose  |"
    echo "     |  to navigate elsewhere.                                                 |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Move to Parent Directory                                            |"
    echo "     |  2. Show Current Directory Path                                         |"
    echo "     |  3. View Current Directory Structure                                    |"
    echo "     |  4. Cancel and Return to Menu                                           |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) move_to_parent ;;
        2) show_current_path ;;
        3) view_directory_structure ;;
        4) cancel_action ;;
        5) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; six_of_clubs_menu ;;
    esac
}

# Option 1: Move to Parent Directory
move_to_parent() {
    clear
    echo -e "${CYAN}Moving to the parent directory...${RESET}"
    cd ..
    echo "You are now in: $(pwd)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

# Option 2: Show Current Directory Path
show_current_path() {
    clear
    echo -e "${CYAN}Current Directory Path:${RESET}"
    echo "$(pwd)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

# Option 3: View Current Directory Structure
view_directory_structure() {
    clear
    echo -e "${CYAN}Current Directory Structure:${RESET}"
    ls -l
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_clubs_menu
}

# Option 4: Cancel and Return to Menu
cancel_action() {
    clear
    echo "Cancelled. Returning to the menu."
    sleep 1
    six_of_clubs_menu
}

# Option 5: Exit Script
exit_script() {
    clear
    echo "Exiting the script. Goodbye!"
    exit 0
}

six_of_clubs_menu
