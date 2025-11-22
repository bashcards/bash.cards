#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Diamonds Card
seven_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Seven of Diamonds                          |"
    echo "     |                       Display User and Group Information                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Explore user and group IDs, primary groups, and all group memberships. |"
    echo "     |                                                                         |"
    echo "     |  1. View current user's IDs                                             |"
    echo "     |  2. View another user's IDs                                             |"
    echo "     |  3. List all groups for a user                                          |"
    echo "     |  4. List all system users and their IDs                                 |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) display_current_user_ids ;;
        2) display_other_user_ids ;;
        3) list_user_groups ;;
        4) list_system_users ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_diamonds_menu ;;
    esac
}

# Display current user's IDs
display_current_user_ids() {
    clear
    echo -e "${CYAN}Displaying current user's IDs...${RESET}"
    id
    echo -e "\nPrimary group: $(id -gn)"
    echo "Supplementary groups: $(id -Gn)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

# Display another user's IDs
display_other_user_ids() {
    clear
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        echo -e "${CYAN}Displaying IDs for user: $username${RESET}"
        id "$username"
        echo -e "\nPrimary group: $(id -gn "$username")"
        echo "Supplementary groups: $(id -Gn "$username")"
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

# List all groups for a user
list_user_groups() {
    clear
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        echo -e "${CYAN}Listing all groups for user: $username${RESET}"
        groups "$username"
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

# List all system users and their IDs
list_system_users() {
    clear
    echo -e "${CYAN}Listing all system users and their IDs...${RESET}"
    awk -F: '{ print $1, $3, $4 }' /etc/passwd | column -t -s' ' | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_diamonds_menu
}

seven_of_diamonds_menu
