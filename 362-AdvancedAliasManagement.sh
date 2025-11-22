#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Diamonds Card
queen_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Queen of Diamonds                          |"
    echo "     |                         Advanced Alias Management                       |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Manage your shell aliases with ease. This card lets you view, add,     |"
    echo "     |  remove, reset, back up, and restore aliases seamlessly.                |"
    echo "     |                                                                         |"
    echo "     |  1. View all current aliases                                            |"
    echo "     |  2. Add a new alias                                                     |"
    echo "     |  3. Remove specific alias(es)                                           |"
    echo "     |  4. Reset all aliases                                                   |"
    echo "     |  5. Backup aliases                                                      |"
    echo "     |  6. Restore aliases                                                     |"
    echo "     |  7. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_aliases ;;
        2) add_alias ;;
        3) remove_aliases ;;
        4) reset_all_aliases ;;
        5) backup_aliases ;;
        6) restore_aliases ;;
        7) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_diamonds_menu ;;
    esac
}

# View all current aliases
view_aliases() {
    clear
    echo -e "${CYAN}Current Aliases:${RESET}"
    alias | awk -F'[=]' '{printf "%-20s -> %s\n", $1, $2}'
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Add a new alias
add_alias() {
    clear
    echo -e "${CYAN}Add a New Alias:${RESET}"
    read -p "Enter the alias name: " alias_name
    read -p "Enter the command for the alias: " alias_command
    alias "$alias_name=$alias_command"
    echo "Alias '$alias_name' added successfully."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Remove specific alias(es)
remove_aliases() {
    clear
    echo -e "${CYAN}Current Aliases:${RESET}"
    mapfile -t aliases < <(alias | awk -F'[=]' '{print $1}')
    for i in "${!aliases[@]}"; do
        printf "%d) %s\n" $((i + 1)) "${aliases[i]}"
    done
    echo "Enter the number(s) of the alias(es) to remove, separated by spaces:"
    read -a alias_numbers
    for num in "${alias_numbers[@]}"; do
        unalias "${aliases[num-1]}"
        echo "Alias '${aliases[num-1]}' removed."
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Reset all aliases
reset_all_aliases() {
    clear
    echo "This will remove all aliases in the current session."
    read -p "Are you sure you want to reset all aliases? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        unalias -a
        echo "All aliases have been reset."
    else
        echo "Operation cancelled."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Backup aliases
backup_aliases() {
    clear
    echo "Backing up current aliases..."
    alias > ~/.alias_backup
    echo "Aliases have been backed up to ~/.alias_backup."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

# Restore aliases
restore_aliases() {
    clear
    if [[ -f ~/.alias_backup ]]; then
        echo "Restoring aliases from backup..."
        source ~/.alias_backup
        echo "Aliases restored successfully."
    else
        echo "No backup file found at ~/.alias_backup."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_diamonds_menu
}

queen_of_diamonds_menu
