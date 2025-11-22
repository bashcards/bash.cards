#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Four of Clubs Card
four_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Four of Clubs                              |"
    echo "     |                          Clear the Terminal Screen                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card clears the terminal screen and provides additional options   |"
    echo "     |  for managing screen output and logs.                                   |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Clear Terminal Screen                                               |"
    echo "     |  2. Save Current Terminal Output to a File                              |"
    echo "     |  3. Display Last Saved Output File                                       |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) clear_terminal ;;
        2) save_terminal_output ;;
        3) display_saved_output ;;
        4) exit_card ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; four_of_clubs_menu ;;
    esac
}

# Option 1: Clear the Terminal Screen
clear_terminal() {
    clear
    echo -e "${CYAN}Terminal screen cleared!${RESET}"
    echo "Scan to return to the menu."
    read -r # Wait for the next scan
    four_of_clubs_menu
}

# Option 2: Save Current Terminal Output to a File
save_terminal_output() {
    clear
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local filename="terminal_output_${timestamp}.txt"
    script -q -c "cat" "$filename"
    echo -e "${CYAN}Terminal output saved to $filename.${RESET}"
    echo "Scan to return to the menu."
    read -r # Wait for the next scan
    four_of_clubs_menu
}

# Option 3: Display Last Saved Output File
display_saved_output() {
    clear
    local files
    files=(*terminal_output_*.txt)
    if (( ${#files[@]} == 0 )); then
        echo -e "${CYAN}No saved output files found.${RESET}"
        echo "Scan to return to the menu."
        read -r # Wait for the next scan
        four_of_clubs_menu
    else
        echo -e "${CYAN}Saved Output Files:${RESET}"
        for i in "${!files[@]}"; do
            printf "%d) %s\n" "$((i + 1))" "${files[$i]}"
        done
        echo "Scan the number of the file to display it or scan to go back."
        read -r file_choice
        if ((file_choice > 0 && file_choice <= ${#files[@]})); then
            less "${files[$((file_choice - 1))]}"
        else
            echo "Invalid choice. Returning to menu."
        fi
        four_of_clubs_menu
    fi
}

# Option 4: Exit the Card
exit_card() {
    clear
    echo "Exiting the Four of Clubs card."
    sleep 1
}

four_of_clubs_menu
