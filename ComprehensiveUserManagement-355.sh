#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Diamonds Card
five_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Five of Diamonds                            |"
    echo "     |                       Comprehensive User Management                      |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  1. Add a new user                                                       |"
    echo "     |  2. Delete an existing user                                              |"
    echo "     |  3. Modify user account settings                                         |"
    echo "     |  4. List all users                                                       |"
    echo "     |  5. View details for a specific user                                     |"
    echo "     |  6. Lock or unlock a user account                                        |"
    echo "     |  7. Add a user to a group                                                |"
    echo "     |  8. Remove a user from a group                                           |"
    echo "     |  9. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) add_new_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) list_all_users ;;
        5) view_user_details ;;
        6) lock_unlock_user ;;
        7) add_user_to_group ;;
        8) remove_user_from_group ;;
        9) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_diamonds_menu ;;
    esac
}

# Add a new user
add_new_user() {
    clear
    echo -e "${CYAN}Add a New User:${RESET}"
    read -p "Enter the username for the new user: " username
    if sudo adduser "$username"; then
        echo "User '$username' added successfully."
    else
        echo "Failed to add user '$username'."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Delete an existing user
delete_user() {
    clear
    echo -e "${CYAN}Delete an Existing User:${RESET}"
    read -p "Enter the username to delete: " username
    if sudo deluser "$username"; then
        echo "User '$username' deleted successfully."
    else
        echo "Failed to delete user '$username'."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Modify user account settings
modify_user() {
    clear
    echo -e "${CYAN}Modify User Account Settings:${RESET}"
    read -p "Enter the username to modify: " username
    echo "Choose an option:"
    echo "1. Change username"
    echo "2. Change home directory"
    echo "3. Change shell"
    echo "4. Change password"
    echo "q. Go back to menu"
    read -p "Choice: " mod_choice

    case $mod_choice in
        1)
            read -p "Enter the new username: " new_username
            if sudo usermod -l "$new_username" "$username"; then
                echo "Username changed successfully."
            else
                echo "Failed to change username."
            fi
            ;;
        2)
            read -p "Enter the new home directory: " new_home
            if sudo usermod -d "$new_home" "$username"; then
                echo "Home directory changed successfully."
            else
                echo "Failed to change home directory."
            fi
            ;;
        3)
            read -p "Enter the new shell (e.g., /bin/bash): " new_shell
            if sudo usermod -s "$new_shell" "$username"; then
                echo "Shell changed successfully."
            else
                echo "Failed to change shell."
            fi
            ;;
        4)
            if sudo passwd "$username"; then
                echo "Password changed successfully."
            else
                echo "Failed to change password."
            fi
            ;;
        q) ;;
        *) echo "Invalid choice."; sleep 1 ;;
    esac
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# List all users
list_all_users() {
    clear
    echo -e "${CYAN}All Users on the System:${RESET}"
    cut -d: -f1 /etc/passwd
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# View details for a specific user
view_user_details() {
    clear
    echo -e "${CYAN}View User Details:${RESET}"
    read -p "Enter the username to view details: " username
    id "$username" && getent passwd "$username"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Lock or unlock a user account
lock_unlock_user() {
    clear
    echo -e "${CYAN}Lock or Unlock a User Account:${RESET}"
    read -p "Enter the username: " username
    echo "1. Lock the account"
    echo "2. Unlock the account"
    read -p "Choice: " lock_choice

    case $lock_choice in
        1)
            if sudo usermod -L "$username"; then
                echo "User '$username' locked."
            else
                echo "Failed to lock user '$username'."
            fi
            ;;
        2)
            if sudo usermod -U "$username"; then
                echo "User '$username' unlocked."
            else
                echo "Failed to unlock user '$username'."
            fi
            ;;
        *) echo "Invalid choice."; sleep 1 ;;
    esac
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Add a user to a group
add_user_to_group() {
    clear
    echo -e "${CYAN}Add a User to a Group:${RESET}"
    read -p "Enter the username: " username
    read -p "Enter the group name: " group_name
    if sudo usermod -aG "$group_name" "$username"; then
        echo "User '$username' added to group '$group_name'."
    else
        echo "Failed to add user '$username' to group '$group_name'."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Remove a user from a group
remove_user_from_group() {
    clear
    echo -e "${CYAN}Remove a User from a Group:${RESET}"
    read -p "Enter the username: " username
    read -p "Enter the group name: " group_name
    if sudo gpasswd -d "$username" "$group_name"; then
        echo "User '$username' removed from group '$group_name'."
    else
        echo "Failed to remove user '$username' from group '$group_name'."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_diamonds_menu
}

# Start the Five of Diamonds card menu
five_of_diamonds_menu
