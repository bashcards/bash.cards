#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Three of Clubs Card
three_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Three of Clubs                             |"
    echo "     |                         Build and Print Custom Text                    |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a user-friendly interface to create custom          |"
    echo "     |  echo commands with colors, styles, and formatting.                     |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Build Custom Echo Command                                           |"
    echo "     |  2. Preview Custom Text                                                 |"
    echo "     |  3. Execute Custom Echo Command                                         |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) build_echo_command ;;
        2) preview_custom_text ;;
        3) execute_custom_command ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_clubs_menu ;;
    esac
}

# Global Variables for Custom Command
custom_color='\033[0m'
custom_style=''
custom_text=''

# Option 1: Build Custom Echo Command
build_echo_command() {
    clear
    echo "Choose a color for the text:"
    echo "1) Red"
    echo "2) Green"
    echo "3) Yellow"
    echo "4) Blue"
    echo "5) Cyan"
    echo "6) No Color"
    read -p "Enter your choice: " color_choice

    case $color_choice in
        1) custom_color='\033[31m' ;;
        2) custom_color='\033[32m' ;;
        3) custom_color='\033[33m' ;;
        4) custom_color='\033[34m' ;;
        5) custom_color='\033[36m' ;;
        6) custom_color='\033[0m' ;;
        *) custom_color='\033[0m' ;;
    esac

    echo "Choose a text style:"
    echo "1) Bold"
    echo "2) Underline"
    echo "3) Blink"
    echo "4) No Style"
    read -p "Enter your choice: " style_choice

    case $style_choice in
        1) custom_style='\033[1m' ;;
        2) custom_style='\033[4m' ;;
        3) custom_style='\033[5m' ;;
        4) custom_style='' ;;
        *) custom_style='' ;;
    esac

    read -p "Enter the text you want to print: " custom_text
    echo "Custom Echo Command Updated."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

# Option 2: Preview Custom Text
preview_custom_text() {
    clear
    echo -e "Your current custom text looks like this:"
    echo -e "${custom_color}${custom_style}${custom_text}${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

# Option 3: Execute Custom Echo Command
execute_custom_command() {
    clear
    echo -e "Executing your custom echo command..."
    echo -e "${custom_color}${custom_style}${custom_text}${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_clubs_menu
}

three_of_clubs_menu
