#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Diamonds Card
ten_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ten of Diamonds                            |"
    echo "     |                      View and Manage Command History                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. View full command history                                           |"
    echo "     |  2. Search history by keyword                                           |"
    echo "     |  3. Execute a previous command                                          |"
    echo "     |  4. Export history to a file                                            |"
    echo "     |  5. Clear command history                                               |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_full_history ;;
        2) search_history ;;
        3) execute_previous_command ;;
        4) export_history ;;
        5) clear_history ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_diamonds_menu ;;
    esac
}

# View full command history
view_full_history() {
    clear
    echo -e "${CYAN}Full Command History:${RESET}"
    history
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Search history by keyword
search_history() {
    clear
    read -p "Enter a keyword to search in history: " keyword
    echo -e "${CYAN}Matching Commands:${RESET}"
    history | grep --color=always "$keyword"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Execute a previous command
execute_previous_command() {
    clear
    echo -e "${CYAN}Select a command to re-execute:${RESET}"
    mapfile -t commands < <(history | awk '{for (i=2; i<=NF; i++) printf $i " "; print ""}' | tail -n 20)
    select cmd in "${commands[@]}" "Cancel"; do
        if [[ $REPLY -gt 0 && $REPLY -le ${#commands[@]} ]]; then
            echo "Executing: $cmd"
            eval "$cmd"
            break
        elif [[ $REPLY -eq $((${#commands[@]} + 1)) ]]; then
            echo "Cancelled."
            break
        else
            echo "Invalid choice. Try again."
        fi
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Export history to a file
export_history() {
    clear
    read -p "Enter the filename to save history (e.g., history.txt): " filename
    history > "$filename"
    echo "History saved to $filename."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

# Clear command history
clear_history() {
    clear
    echo -e "${CYAN}Are you sure you want to clear the command history? This action cannot be undone.${RESET}"
    read -p "Type 'yes' to confirm: " confirm
    if [[ $confirm == "yes" ]]; then
        history -c
        echo "Command history cleared."
    else
        echo "Operation canceled."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_diamonds_menu
}

ten_of_diamonds_menu
