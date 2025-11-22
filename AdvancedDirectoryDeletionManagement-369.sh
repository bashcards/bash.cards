#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Six of Spades Card
six_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Six of Spades                              |"
    echo "     |                    Advanced Directory Deletion and Management           |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a secure, interactive way to delete empty           |"
    echo "     |  directories and offers tools to clean up directory structures,         |"
    echo "     |  analyze directory sizes, and schedule deletions.                       |"
    echo "     |                                                                         |"
    echo "     |  1. Delete an empty directory                                           |"
    echo "     |  2. List all empty directories                                          |"
    echo "     |  3. Analyze directory sizes                                             |"
    echo "     |  4. Schedule deletion of directories                                    |"
    echo "     |  5. Cleanup orphaned directories                                        |"
    echo "     |  6. Return to menu                                                      |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) delete_empty_directory ;;
        2) list_empty_directories ;;
        3) analyze_directory_sizes ;;
        4) schedule_deletion ;;
        5) cleanup_orphaned_directories ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; six_of_spades_menu ;;
    esac
}

# Function to delete an empty directory
delete_empty_directory() {
    clear
    echo -e "${CYAN}Delete an Empty Directory${RESET}"
    read -p "Enter the directory path to delete: " dir_path

    if [[ -d $dir_path ]]; then
        if [[ -z "$(ls -A "$dir_path")" ]]; then
            rmdir "$dir_path"
            echo -e "${GREEN}Directory successfully deleted: $dir_path${RESET}"
        else
            echo -e "${RED}Error: Directory is not empty.${RESET}"
        fi
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Function to list all empty directories
list_empty_directories() {
    clear
    echo -e "${CYAN}List of Empty Directories${RESET}"
    find . -type d -empty -print | sort
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Function to analyze directory sizes
analyze_directory_sizes() {
    clear
    echo -e "${CYAN}Analyzing Directory Sizes${RESET}"
    du -h --max-depth=1 | sort -hr
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Function to schedule deletion of directories
schedule_deletion() {
    clear
    echo -e "${CYAN}Schedule Directory Deletion${RESET}"
    read -p "Enter the directory path to schedule for deletion: " dir_path
    read -p "Enter the time delay in minutes: " delay

    if [[ -d $dir_path ]]; then
        echo "rmdir \"$dir_path\"" | at now + "$delay" minutes
        echo -e "${GREEN}Scheduled deletion of $dir_path in $delay minutes.${RESET}"
    else
        echo -e "${RED}Error: Directory does not exist.${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

# Function to cleanup orphaned directories
cleanup_orphaned_directories() {
    clear
    echo -e "${CYAN}Cleaning Up Orphaned Directories${RESET}"
    find . -type d -empty -exec rmdir {} +
    echo -e "${GREEN}All orphaned directories have been removed.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_spades_menu
}

six_of_spades_menu
