#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Six of Diamonds Card
six_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Diamonds                            |"
    echo "     |                     Comprehensive Password Management                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Manage passwords for users with advanced options and security features.|"
    echo "     |                                                                         |"
    echo "     |  1. Change current user's password                                      |"
    echo "     |  2. Change another user's password                                      |"
    echo "     |  3. Force password change on next login                                 |"
    echo "     |  4. Set password expiration policies                                    |"
    echo "     |  5. Lock a user's password                                              |"
    echo "     |  6. Unlock a user's password                                            |"
    echo "     |  7. Audit user password settings                                        |"
    echo "     |  8. Batch operations (multiple users)                                   |"
    echo "     |  9. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) change_current_user_password ;;
        2) change_other_user_password ;;
        3) force_password_change ;;
        4) set_password_policies ;;
        5) lock_user_password ;;
        6) unlock_user_password ;;
        7) audit_password_settings ;;
        8) batch_operations ;;
        9) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_diamonds_menu ;;
    esac
}

# Change the current user's password
change_current_user_password() {
    clear
    echo -e "${CYAN}Changing current user's password...${RESET}"
    passwd
    echo "Password changed successfully."
    log_action "Changed password for current user."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Change another user's password
change_other_user_password() {
    clear
    echo -e "${CYAN}Changing another user's password...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        passwd "$username"
        echo "Password changed successfully for $username."
        log_action "Changed password for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Force password change on next login
force_password_change() {
    clear
    echo -e "${CYAN}Forcing password change on next login...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        chage -d 0 "$username"
        echo "Password change forced for $username."
        log_action "Forced password change for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Set password expiration policies
set_password_policies() {
    clear
    echo -e "${CYAN}Setting password expiration policies...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        read -p "Enter maximum days until password change (e.g., 90): " max_days
        read -p "Enter minimum days before password change (e.g., 7): " min_days
        read -p "Enter days for expiration warning (e.g., 14): " warn_days
        chage -M "$max_days" -m "$min_days" -W "$warn_days" "$username"
        echo "Password policies set for $username."
        log_action "Set password policies for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Lock a user's password
lock_user_password() {
    clear
    echo -e "${CYAN}Locking a user's password...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        passwd -l "$username"
        echo "Password locked for $username."
        log_action "Locked password for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Unlock a user's password
unlock_user_password() {
    clear
    echo -e "${CYAN}Unlocking a user's password...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        passwd -u "$username"
        echo "Password unlocked for $username."
        log_action "Unlocked password for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Audit user password settings
audit_password_settings() {
    clear
    echo -e "${CYAN}Auditing user password settings...${RESET}"
    read -p "Enter the username: " username
    if id "$username" &>/dev/null; then
        chage -l "$username"
        log_action "Audited password settings for user $username."
    else
        echo "User $username does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Perform batch operations for multiple users
batch_operations() {
    clear
    echo -e "${CYAN}Batch operations for multiple users...${RESET}"
    read -p "Enter usernames separated by space: " -a users
    echo "1. Change passwords"
    echo "2. Force password changes"
    echo "3. Lock passwords"
    echo "4. Unlock passwords"
    read -p "Choose an operation: " operation

    for user in "${users[@]}"; do
        if id "$user" &>/dev/null; then
            case $operation in
                1) passwd "$user" ;;
                2) chage -d 0 "$user" ;;
                3) passwd -l "$user" ;;
                4) passwd -u "$user" ;;
                *) echo "Invalid operation for $user." ;;
            esac
            log_action "Batch operation $operation applied to user $user."
        else
            echo "User $user does not exist. Skipping..."
        fi
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_diamonds_menu
}

# Log actions for auditing purposes
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> /var/log/password_management.log
}

six_of_diamonds_menu
