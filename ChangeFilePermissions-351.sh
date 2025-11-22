#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

# Menu for the Ace of Diamonds Card
ace_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Ace of Diamonds                             |"
    echo "     |                          Change File Permissions                         |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card lets you securely change file or directory permissions.        |"
    echo "     |                                                                          |"
    echo "     |  1. Select a file or directory                                           |"
    echo "     |  2. Apply permission changes                                             |"
    echo "     |  3. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) select_file ;;
        2) apply_permissions ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ace_of_diamonds_menu ;;
    esac
}

# Function to list and select a file or directory
select_file() {
    clear
    echo -e "${CYAN}Select a file or directory:${RESET}"
    mapfile -t files < <(ls -1)
    for i in "${!files[@]}"; do
        echo "$((i + 1)). ${files[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " file_choice
    if [[ $file_choice == "q" ]]; then
        ace_of_diamonds_menu
    elif ((file_choice > 0 && file_choice <= ${#files[@]})); then
        selected_file="${files[file_choice - 1]}"
        echo "You selected: $selected_file"
        sleep 1
        ace_of_diamonds_menu
    else
        echo "Invalid choice. Try again."
        sleep 1
        select_file
    fi
}

# Function to apply permissions
apply_permissions() {
    if [[ -z $selected_file ]]; then
        echo -e "${RED}No file or directory selected. Please select one first.${RESET}"
        sleep 2
        ace_of_diamonds_menu
        return
    fi
    clear
    echo -e "${CYAN}Select a permission change:${RESET}"
    options=(
        # Symbolic permissions
        "u+x (Add execute permission for the user)"
        "u-r (Remove read permission for the user)"
        "u+w (Add write permission for the user)"
        "g+x (Add execute permission for the group)"
        "g-w (Remove write permission for the group)"
        "o+r (Add read permission for others)"
        "o-w (Remove write permission for others)"
        "a+x (Add execute permission for all)"
        "a-r (Remove read permission for all)"
        "a+w (Add write permission for all)"
        # Octal permissions
        "777 (All permissions for everyone)"
        "755 (Owner: rwx, Group: rx, Others: rx)"
        "700 (Owner: rwx, Group: none, Others: none)"
        "644 (Owner: rw, Group: r, Others: r)"
        "600 (Owner: rw, Group: none, Others: none)"
        "555 (Read and execute for all, no write)"
        "400 (Read-only for owner)"
        "000 (No permissions)"
        "Custom symbolic mode (e.g., u=rwx,go=rx)"
        "Custom octal mode (e.g., 764)"
    )
    for i in "${!options[@]}"; do
        echo "$((i + 1)). ${options[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " perm_choice
    if [[ $perm_choice == "q" ]]; then
        ace_of_diamonds_menu
    elif ((perm_choice > 0 && perm_choice <= ${#options[@]})); then
        if ((perm_choice == ${#options[@]} - 1)); then
            read -p "Enter custom symbolic mode: " custom_mode
            chmod "$custom_mode" "$selected_file"
            echo "Custom symbolic mode $custom_mode applied to $selected_file."
        elif ((perm_choice == ${#options[@]})); then
            read -p "Enter custom octal mode: " custom_mode
            chmod "$custom_mode" "$selected_file"
            echo "Custom octal mode $custom_mode applied to $selected_file."
        else
            chmod "${options[perm_choice - 1]%% *}" "$selected_file"
            echo "${options[perm_choice - 1]} applied to $selected_file."
        fi
    else
        echo "Invalid choice. Try again."
    fi
    sleep 2
    ace_of_diamonds_menu
}

# Start the Ace of Diamonds card menu
ace_of_diamonds_menu
