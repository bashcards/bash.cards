#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'

# Menu for the Seven of Spades Card
seven_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Seven of Spades                            |"
    echo "     |                    Advanced File Editing with Nano                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides an interactive interface for editing files using    |"
    echo "     |  the nano text editor. Additionally, it offers options to create, open  |"
    echo "     |  or view files, and a guided editing mode for beginners.                |"
    echo "     |                                                                         |"
    echo "     |  1. Open a file for editing                                             |"
    echo "     |  2. Create a new file                                                   |"
    echo "     |  3. View a file (read-only mode)                                        |"
    echo "     |  4. Guided editing mode (step-by-step instructions)                     |"
    echo "     |  5. Return to menu                                                      |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) open_file ;;
        2) create_file ;;
        3) view_file ;;
        4) guided_editing ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_spades_menu ;;
    esac
}

# Open a file for editing
open_file() {
    clear
    echo -e "${CYAN}Open a File for Editing${RESET}"
    read -p "Enter the file path to open: " file_path

    if [[ -f $file_path ]]; then
        nano "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
    fi
    seven_of_spades_menu
}

# Create a new file
create_file() {
    clear
    echo -e "${CYAN}Create a New File${RESET}"
    read -p "Enter the file path to create: " file_path

    if [[ -e $file_path ]]; then
        echo -e "${RED}Error: File already exists.${RESET}"
    else
        nano "$file_path"
        echo -e "${GREEN}File created successfully: $file_path${RESET}"
    fi

    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_spades_menu
}

# View a file in read-only mode
view_file() {
    clear
    echo -e "${CYAN}View a File (Read-Only Mode)${RESET}"
    read -p "Enter the file path to view: " file_path

    if [[ -f $file_path ]]; then
        less "$file_path"
    else
        echo -e "${RED}Error: File does not exist.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
    fi
    seven_of_spades_menu
}

# Guided editing mode
guided_editing() {
    clear
    echo -e "${CYAN}Guided Editing Mode${RESET}"
    echo "This mode will guide you step-by-step to edit a file."
    echo -e "${YELLOW}Step 1:${RESET} Enter the path of the file you want to edit or create."
    read -p "File path: " file_path

    if [[ -f $file_path ]]; then
        echo -e "${GREEN}File exists. Opening it in nano.${RESET}"
    else
        echo -e "${YELLOW}File does not exist. A new file will be created.${RESET}"
    fi

    nano "$file_path"

    echo -e "${YELLOW}Step 2:${RESET} Use nano's interface to make changes."
    echo -e "${YELLOW}Step 3:${RESET} Save your changes by pressing ${GREEN}Ctrl+O${RESET} and then ${GREEN}Enter${RESET}."
    echo -e "${YELLOW}Step 4:${RESET} Exit nano by pressing ${GREEN}Ctrl+X${RESET}."
    echo -e "${GREEN}Guided editing complete!${RESET}"

    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_spades_menu
}

seven_of_spades_menu
