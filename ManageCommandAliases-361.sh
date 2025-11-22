#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Jack of Diamonds Card
jack_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Jack of Diamonds                           |"
    echo "     |                           Manage Command Aliases                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. View all current aliases                                            |"
    echo "     |  2. Create a new alias                                                  |"
    echo "     |  3. Remove an alias                                                     |"
    echo "     |  4. Export aliases to a file                                            |"
    echo "     |  5. Load aliases from a file                                            |"
    echo "     |  6. Search for an alias                                                 |"
    echo "     |  7. Test an alias                                                       |"
    echo "     |  8. Reset all aliases                                                   |"
    echo "     |  9. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_aliases ;;
        2) create_alias ;;
        3) remove_alias ;;
        4) export_aliases ;;
        5) load_aliases ;;
        6) search_alias ;;
        7) test_alias ;;
        8) reset_aliases ;;
        9) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; jack_of_diamonds_menu ;;
    esac
}

# View all current aliases
view_aliases() {
    clear
    echo -e "${CYAN}Current Aliases:${RESET}"
    alias
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Create a new alias
create_alias() {
    clear
    read -p "Enter the alias name: " alias_name
    read -p "Enter the command to associate with the alias: " alias_command
    alias "$alias_name=$alias_command"
    echo "Alias '$alias_name' created for command: $alias_command"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Remove an alias
remove_alias() {
    clear
    echo -e "${CYAN}Current Aliases:${RESET}"
    alias | awk -F= '{print NR ") " $1}'
    read -p "Enter the name of the alias to remove: " alias_name
    unalias "$alias_name"
    echo "Alias '$alias_name' removed."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Export aliases to a file
export_aliases() {
    clear
    read -p "Enter the filename to save aliases (e.g., aliases.sh): " filename
    alias > "$filename"
    echo "Aliases exported to $filename."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Load aliases from a file
load_aliases() {
    clear
    read -p "Enter the filename to load aliases from: " filename
    if [[ -f "$filename" ]]; then
        source "$filename"
        echo "Aliases loaded from $filename."
    else
        echo "File $filename not found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Search for an alias
search_alias() {
    clear
    read -p "Enter the alias name to search for: " search_term
    alias | grep --color=always "$search_term" || echo "No alias found matching '$search_term'."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Test an alias
test_alias() {
    clear
    read -p "Enter the alias name to test: " alias_name
    eval "$(alias "$alias_name" 2>/dev/null)" && echo "Alias '$alias_name' executed successfully." || echo "Alias '$alias_name' not found or failed to execute."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

# Reset all aliases
reset_aliases() {
    clear
    echo "This will remove all aliases in the current session."
    read -p "Are you sure? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        unalias -a
        echo "All aliases have been reset."
    else
        echo "Operation cancelled."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    jack_of_diamonds_menu
}

jack_of_diamonds_menu
