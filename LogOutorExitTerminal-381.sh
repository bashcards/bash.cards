#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Clubs Card
five_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Five of Clubs                              |"
    echo "     |                         Log Out or Exit Terminal                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides options to log out, exit the terminal, or switch    |"
    echo "     |  users. Choose from the available options below.                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Exit the Current Shell                                              |"
    echo "     |  2. Log Out of the Current Session                                      |"
    echo "     |  3. Switch to Another User                                              |"
    echo "     |  4. Cancel and Return to Menu                                           |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) exit_shell ;;
        2) logout_session ;;
        3) switch_user ;;
        4) cancel_exit ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; five_of_clubs_menu ;;
    esac
}

# Option 1: Exit the Current Shell
exit_shell() {
    clear
    echo -e "${CYAN}Exiting the current shell...${RESET}"
    sleep 1
    exit 0
}

# Option 2: Log Out of the Current Session
logout_session() {
    clear
    echo -e "${CYAN}Logging out of the current session...${RESET}"
    sleep 1
    logout
}

# Option 3: Switch to Another User
switch_user() {
    clear
    echo -e "${CYAN}Switching to another user...${RESET}"
    if command -v su &>/dev/null; then
        echo "Scan a card for the user account to switch to."
        echo "Alternatively, scan to return to the menu."
        read -r # Await user scan input for the target username or return
        su
    else
        echo "The 'su' command is not available on this system."
        echo "Returning to the menu."
        sleep 2
    fi
    five_of_clubs_menu
}

# Option 4: Cancel and Return to Menu
cancel_exit() {
    clear
    echo "Cancelled. Returning to the menu."
    sleep 1
    five_of_clubs_menu
}

five_of_clubs_menu
