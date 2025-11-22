#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'

# Menu for the Two of Diamonds Card
two_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Two of Diamonds                             |"
    echo "     |                          Change File Ownership                           |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to interactively change the owner and group of a   |"
    echo "     |  selected file or directory.                                             |"
    echo "     |                                                                          |"
    echo "     |  1. Select a file or directory                                           |"
    echo "     |  2. Change owner                                                         |"
    echo "     |  3. Change group                                                         |"
    echo "     |  4. Change both owner and group                                          |"
    echo "     |  5. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) select_file ;;
        2) change_owner ;;
        3) change_group ;;
        4) change_owner_group ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; two_of_diamonds_menu ;;
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
        two_of_diamonds_menu
    elif ((file_choice > 0 && file_choice <= ${#files[@]})); then
        selected_file="${files[file_choice - 1]}"
        echo "You selected: $selected_file"
        sleep 1
        two_of_diamonds_menu
    else
        echo "Invalid choice. Try again."
        sleep 1
        select_file
    fi
}

# Function to change owner
change_owner() {
    if [[ -z $selected_file ]]; then
        echo -e "${RED}No file or directory selected. Please select one first.${RESET}"
        sleep 2
        two_of_diamonds_menu
        return
    fi
    clear
    echo -e "${CYAN}Available users:${RESET}"
    mapfile -t users < <(cut -d: -f1 /etc/passwd)
    for i in "${!users[@]}"; do
        echo "$((i + 1)). ${users[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter the number of the new owner: " user_choice
    if [[ $user_choice == "q" ]]; then
        two_of_diamonds_menu
    elif ((user_choice > 0 && user_choice <= ${#users[@]})); then
        new_owner="${users[user_choice - 1]}"
        chown "$new_owner" "$selected_file"
        echo -e "${GREEN}Owner changed to $new_owner for $selected_file.${RESET}"
    else
        echo "Invalid choice. Try again."
    fi
    sleep 2
    two_of_diamonds_menu
}

# Function to change group
change_group() {
    if [[ -z $selected_file ]]; then
        echo -e "${RED}No file or directory selected. Please select one first.${RESET}"
        sleep 2
        two_of_diamonds_menu
        return
    fi
    clear
    echo -e "${CYAN}Available groups:${RESET}"
    mapfile -t groups < <(cut -d: -f1 /etc/group)
    for i in "${!groups[@]}"; do
        echo "$((i + 1)). ${groups[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter the number of the new group: " group_choice
    if [[ $group_choice == "q" ]]; then
        two_of_diamonds_menu
    elif ((group_choice > 0 && group_choice <= ${#groups[@]})); then
        new_group="${groups[group_choice - 1]}"
        chown ":$new_group" "$selected_file"
        echo -e "${GREEN}Group changed to $new_group for $selected_file.${RESET}"
    else
        echo "Invalid choice. Try again."
    fi
    sleep 2
    two_of_diamonds_menu
}

# Function to change both owner and group
change_owner_group() {
    if [[ -z $selected_file ]]; then
        echo -e "${RED}No file or directory selected. Please select one first.${RESET}"
        sleep 2
        two_of_diamonds_menu
        return
    fi
    change_owner
    change_group
}

# Start the Two of Diamonds card menu
two_of_diamonds_menu
