#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Eight of Diamonds Card
eight_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Eight of Diamonds                          |"
    echo "     |                            Switch to Another User                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Provides the ability to switch to another user account securely.       |"
    echo "     |                                                                         |"
    echo "     |  1. Switch to a user from a list                                        |"
    echo "     |  2. Manually enter a username                                           |"
    echo "     |  3. View available users                                                |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) switch_from_list ;;
        2) switch_manually ;;
        3) list_available_users ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_diamonds_menu ;;
    esac
}

# List available users
list_available_users() {
    clear
    echo -e "${CYAN}Available system users:${RESET}"
    awk -F: '{ if ($3 >= 1000 && $3 != 65534) print $1 }' /etc/passwd
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_diamonds_menu
}

# Switch to a user from a list
switch_from_list() {
    clear
    echo -e "${CYAN}Select a user to switch to:${RESET}"
    users=($(awk -F: '{ if ($3 >= 1000 && $3 != 65534) print $1 }' /etc/passwd))
    select user in "${users[@]}" "Cancel"; do
        if [[ $REPLY -gt 0 && $REPLY -le ${#users[@]} ]]; then
            echo "Switching to user: $user"
            su - "$user"
            break
        elif [[ $REPLY -eq $((${#users[@]} + 1)) ]]; then
            echo "Cancelled."
            break
        else
            echo "Invalid choice. Try again."
        fi
    done
    eight_of_diamonds_menu
}

# Manually switch to another user
switch_manually() {
    clear
    read -p "Enter the username to switch to: " username
    if id "$username" &>/dev/null; then
        echo "Switching to user: $username"
        su - "$username"
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_diamonds_menu
}

eight_of_diamonds_menu
