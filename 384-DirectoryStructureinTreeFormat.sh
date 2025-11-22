#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Eight of Clubs Card
eight_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Eight of Clubs                             |"
    echo "     |                   Display Directory Structure in Tree Format            |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card lets you view the directory structure in a tree-like format  |"
    echo "     |  with additional options for filtering and depth control.               |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Show Full Directory Tree                                            |"
    echo "     |  2. Show Tree with Limited Depth                                        |"
    echo "     |  3. Show Tree for Specific Subdirectory                                 |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) show_full_tree ;;
        2) show_limited_depth_tree ;;
        3) show_specific_subdirectory_tree ;;
        4) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; eight_of_clubs_menu ;;
    esac
}

# Option 1: Show Full Directory Tree
show_full_tree() {
    clear
    if ! command -v tree &> /dev/null; then
        echo -e "${CYAN}Error: 'tree' command is not installed. Please install it first.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        eight_of_clubs_menu
    fi
    echo -e "${CYAN}Full Directory Tree:${RESET}"
    tree
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_clubs_menu
}

# Option 2: Show Tree with Limited Depth
show_limited_depth_tree() {
    clear
    if ! command -v tree &> /dev/null; then
        echo -e "${CYAN}Error: 'tree' command is not installed. Please install it first.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        eight_of_clubs_menu
    fi
    read -p "Enter the depth level (e.g., 1 for current directory only): " depth
    echo -e "${CYAN}Directory Tree with Depth $depth:${RESET}"
    tree -L "$depth"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_clubs_menu
}

# Option 3: Show Tree for Specific Subdirectory
show_specific_subdirectory_tree() {
    clear
    if ! command -v tree &> /dev/null; then
        echo -e "${CYAN}Error: 'tree' command is not installed. Please install it first.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        eight_of_clubs_menu
    fi
    echo -e "${CYAN}Available Subdirectories:${RESET}"
    select dir in */; do
        if [ -n "$dir" ]; then
            echo -e "${CYAN}Tree for $dir:${RESET}"
            tree "$dir"
            read -n 1 -s -r -p "Press any key to return to the menu..."
            eight_of_clubs_menu
        else
            echo "Invalid choice. Returning to menu."
            sleep 1
            eight_of_clubs_menu
        fi
    done
}

# Option 4: Exit Script
exit_script() {
    clear
    exit 0
}

eight_of_clubs_menu
