#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Three of Diamonds Card
three_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Three of Diamonds                           |"
    echo "     |                     View File Permissions and Ownership                  |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card displays file permissions, ownership, and other details       |"
    echo "     |  for selected files or directories with advanced options.                |"
    echo "     |                                                                          |"
    echo "     |  1. List all files, including hidden ones                                |"
    echo "     |  2. List with human-readable file sizes                                  |"
    echo "     |  3. List sorted by modification time                                     |"
    echo "     |  4. List sorted by file size                                             |"
    echo "     |  5. List details recursively in directories                              |"
    echo "     |  6. Combine custom options (interactive selection)                       |"
    echo "     |  7. View details of a specific file or directory                         |"
    echo "     |  8. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_all_files ;;
        2) list_human_readable ;;
        3) list_by_mod_time ;;
        4) list_by_size ;;
        5) list_recursive ;;
        6) custom_ls_options ;;
        7) view_specific_details ;;
        8) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_diamonds_menu ;;
    esac
}

# Function to list all files, including hidden ones
list_all_files() {
    clear
    echo -e "${CYAN}All files, including hidden ones:${RESET}"
    ls -la
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to list with human-readable file sizes
list_human_readable() {
    clear
    echo -e "${CYAN}Files with human-readable sizes:${RESET}"
    ls -lh
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to list sorted by modification time
list_by_mod_time() {
    clear
    echo -e "${CYAN}Files sorted by modification time:${RESET}"
    ls -lt
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to list sorted by file size
list_by_size() {
    clear
    echo -e "${CYAN}Files sorted by size:${RESET}"
    ls -lS
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to list recursively in directories
list_recursive() {
    clear
    echo -e "${CYAN}Detailed recursive listing of directories:${RESET}"
    ls -lR
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to combine custom options interactively
custom_ls_options() {
    clear
    echo -e "${CYAN}Combine custom options:${RESET}"
    echo "1. Include hidden files (-a)"
    echo "2. Human-readable sizes (-h)"
    echo "3. Sort by modification time (-t)"
    echo "4. Sort by size (-S)"
    echo "5. Recursive listing (-R)"
    echo "6. Exit to menu"
    read -p "Choose options (separate by spaces, e.g., 1 2): " options
    local args=""
    for opt in $options; do
        case $opt in
            1) args+=" -a" ;;
            2) args+=" -h" ;;
            3) args+=" -t" ;;
            4) args+=" -S" ;;
            5) args+=" -R" ;;
            6) three_of_diamonds_menu ;;
            *) echo "Invalid choice: $opt" ;;
        esac
    done
    clear
    echo -e "${CYAN}Custom listing with options:$args${RESET}"
    ls $args
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Function to view details of a specific file or directory
view_specific_details() {
    clear
    echo -e "${CYAN}Select a file or directory:${RESET}"
    mapfile -t items < <(ls -1)
    for i in "${!items[@]}"; do
        echo "$((i + 1)). ${items[i]}"
    done
    echo "q. Go back to the menu"
    read -p "Enter your choice: " item_choice
    if [[ $item_choice == "q" ]]; then
        three_of_diamonds_menu
    elif ((item_choice > 0 && item_choice <= ${#items[@]})); then
        selected_item="${items[item_choice - 1]}"
        echo -e "${CYAN}Details of $selected_item:${RESET}"
        ls -l "$selected_item"
    else
        echo "Invalid choice. Try again."
        sleep 1
        view_specific_details
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Start the Three of Diamonds card menu
three_of_diamonds_menu
