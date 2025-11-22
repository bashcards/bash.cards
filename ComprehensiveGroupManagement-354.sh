#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Four of Diamonds Card
four_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Four of Diamonds                            |"
    echo "     |                       Comprehensive Group Management                     |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  1. List groups for the current user                                     |"
    echo "     |  2. View details for a specific group                                    |"
    echo "     |  3. List all groups on the system                                        |"
    echo "     |  4. Add a new group                                                      |"
    echo "     |  5. Delete an existing group                                             |"
    echo "     |  6. Add a user to a group                                                |"
    echo "     |  7. Remove a user from a group                                           |"
    echo "     |  8. View members of a specific group                                     |"
    echo "     |  9. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_user_groups ;;
        2) view_group_details ;;
        3) list_all_groups ;;
        4) add_new_group ;;
        5) delete_group ;;
        6) add_user_to_group ;;
        7) remove_user_from_group ;;
        8) view_group_members ;;
        9) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; four_of_diamonds_menu ;;
    esac
}

# List groups for the current user
list_user_groups() {
    clear
    echo -e "${CYAN}Groups for the current user:${RESET}"
    groups
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# View details for a specific group
view_group_details() {
    clear
    echo -e "${CYAN}Select a group to view details:${RESET}"
    mapfile -t group_list < <(cut -d: -f1 /etc/group)
    for i in "${!group_list[@]}"; do
        echo "$((i + 1)). ${group_list[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " group_choice
    if [[ $group_choice == "q" ]]; then
        four_of_diamonds_menu
    elif ((group_choice > 0 && group_choice <= ${#group_list[@]})); then
        selected_group="${group_list[group_choice - 1]}"
        echo -e "${CYAN}Details for group '$selected_group':${RESET}"
        getent group "$selected_group"
    else
        echo "Invalid choice. Try again."
        sleep 1
        view_group_details
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# List all groups on the system
list_all_groups() {
    clear
    echo -e "${CYAN}All groups on the system:${RESET}"
    getent group | cut -d: -f1
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# Add a new group
add_new_group() {
    clear
    echo -e "${CYAN}Add a New Group:${RESET}"
    read -p "Enter the name of the new group: " group_name
    if sudo groupadd "$group_name"; then
        echo "Group '$group_name' added successfully."
    else
        echo "Failed to add group '$group_name'."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# Delete an existing group
delete_group() {
    clear
    echo -e "${CYAN}Delete an Existing Group:${RESET}"
    mapfile -t group_list < <(cut -d: -f1 /etc/group)
    for i in "${!group_list[@]}"; do
        echo "$((i + 1)). ${group_list[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " group_choice
    if [[ $group_choice == "q" ]]; then
        four_of_diamonds_menu
    elif ((group_choice > 0 && group_choice <= ${#group_list[@]})); then
        selected_group="${group_list[group_choice - 1]}"
        if sudo groupdel "$selected_group"; then
            echo "Group '$selected_group' deleted successfully."
        else
            echo "Failed to delete group '$selected_group'."
        fi
    else
        echo "Invalid choice. Try again."
        sleep 1
        delete_group
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
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
    four_of_diamonds_menu
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
    four_of_diamonds_menu
}

# View members of a specific group
view_group_members() {
    clear
    echo -e "${CYAN}Select a group to view members:${RESET}"
    mapfile -t group_list < <(cut -d: -f1 /etc/group)
    for i in "${!group_list[@]}"; do
        echo "$((i + 1)). ${group_list[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " group_choice
    if [[ $group_choice == "q" ]]; then
        four_of_diamonds_menu
    elif ((group_choice > 0 && group_choice <= ${#group_list[@]})); then
        selected_group="${group_list[group_choice - 1]}"
        echo -e "${CYAN}Members of group '$selected_group':${RESET}"
        getent group "$selected_group" | awk -F: '{print $4}'
    else
        echo "Invalid choice. Try again."
        sleep 1
        view_group_members
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# Start the Four of Diamonds card menu
four_of_diamonds_menu
