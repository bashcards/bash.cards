#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Four of Hearts Card
four_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Four of Hearts                              |"
    echo "     |                     Identify the Current Logged-In User                  |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to identify the currently logged-in user           |"
    echo "     |  and perform advanced system user management.                            |"
    echo "     |                                                                          |"
    echo "     |  1. Display Current User                                                 |"
    echo "     |  2. Display User Information                                             |"
    echo "     |  3. List All Logged-In Users                                             |"
    echo "     |  4. Search for a User                                                    |"
    echo "     |  5. Check User Login History                                             |"
    echo "     |  6. Display Group Memberships                                            |"
    echo "     |  7. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) display_current_user ;;
        2) display_user_info ;;
        3) list_logged_in_users ;;
        4) search_for_user ;;
        5) check_user_login_history ;;
        6) display_group_memberships ;;
        7) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; four_of_hearts_menu ;;
    esac
}

# Display the current user
display_current_user() {
    clear
    echo -e "${CYAN}Current User:${RESET} $(whoami)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

# Display detailed information about the current user
display_user_info() {
    clear
    echo -e "${CYAN}User Information for $(whoami):${RESET}"
    id
    echo -e "\n${CYAN}Home Directory:${RESET} $HOME"
    echo -e "${CYAN}Shell:${RESET} $SHELL"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

# List all logged-in users
list_logged_in_users() {
    clear
    echo -e "${CYAN}Currently Logged-In Users:${RESET}"
    who
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

# Search for a specific user in the system
search_for_user() {
    clear
    read -p "Enter the username to search: " username
    if id "$username" &>/dev/null; then
        echo -e "${CYAN}User '$username' exists on the system.${RESET}"
        id "$username"
    else
        echo -e "${RED}User '$username' not found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

# Check user login history
check_user_login_history() {
    clear
    read -p "Enter the username to view login history (leave blank for all users): " username
    if [[ -z $username ]]; then
        echo -e "${CYAN}Displaying login history for all users:${RESET}"
        last
    else
        echo -e "${CYAN}Displaying login history for user '$username':${RESET}"
        last "$username"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

# Display all groups the current user belongs to
display_group_memberships() {
    clear
    echo -e "${CYAN}Group Memberships for $(whoami):${RESET}"
    groups
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_hearts_menu
}

four_of_hearts_menu
