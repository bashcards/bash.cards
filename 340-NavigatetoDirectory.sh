#line 62?

#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Three of Hearts Card
three_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Three of Hearts                            |"
    echo "     |                       Navigate to a Specific Directory                  |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to navigate the filesystem with ease.             |"
    echo "     |  Choose from listed directories to move to a specific location.         |"
    echo "     |                                                                         |"
    echo "     |  1. List Current Directory Contents                                     |"
    echo "     |  2. Go to the Home Directory                                            |"
    echo "     |  3. Go Back to the Previous Directory                                   |"
    echo "     |  4. Navigate Up One Level                                               |"
    echo "     |  5. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_and_select ;;
        2) go_home ;;
        3) go_back ;;
        4) go_up ;;
        5) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; three_of_hearts_menu ;;
    esac
}

# List current directory contents and allow navigation
list_and_select() {
    clear
    echo -e "${CYAN}Current Directory: $(pwd)${RESET}"
    echo "Choose a directory to navigate into:"
    options=()
    index=1

    for item in */; do
        options+=("$item")
        echo "$index. $item"
        ((index++))
    done

    if [[ ${#options[@]} -eq 0 ]]; then
        echo -e "${RED}No directories available to navigate.${RESET}"
        read -n 1 -s -r -p "Press any key to return to the menu..."
        three_of_hearts_menu
    fi

    echo "${index}. Go back to the menu"
    read -p "Enter your choice: " dir_choice

    if ((dir_choice > 0 && dir_choice <= ${#options[@]})); then
        cd "${options[$((dir_choice - 1))]}" || return
        echo -e "${GREEN}Moved to directory: $(pwd)${RESET}"
    elif ((dir_choice == index)); then
        three_of_hearts_menu
    else
        echo -e "${RED}Invalid choice. Try again.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

# Go to the home directory
go_home() {
    clear
    cd ~ || return
    echo -e "${GREEN}Moved to home directory: $(pwd)${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

# Go back to the previous directory
go_back() {
    clear
    cd - || return
    echo -e "${GREEN}Moved back to: $(pwd)${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

# Navigate up one level
go_up() {
    clear
    cd .. || return
    echo -e "${GREEN}Moved up to: $(pwd)${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_hearts_menu
}

three_of_hearts_menu
