#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Clubs Card
nine_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Nine of Clubs                              |"
    echo "     |                  Locate the Executable File of a Command                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card helps you find the location of an executable file for a      |"
    echo "     |  command on your system. It uses the 'which' command to do so.          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Locate an Executable File                                           |"
    echo "     |  2. View All Executable Commands in PATH                                |"
    echo "     |  3. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    echo "Scan a card or select an option:"
    read -r choice
    case $choice in
        1) locate_executable ;;
        2) list_executables ;;
        3) exit_script ;;
        *) echo "Invalid choice. Returning to menu..."; sleep 1; nine_of_clubs_menu ;;
    esac
}

# Option 1: Locate an Executable File
locate_executable() {
    clear
    echo "Select a command to locate its executable:"
    commands=("ls" "grep" "echo" "cat" "nano" "vi" "bash" "python3" "gcc" "curl" "wget" "git" "docker" "Cancel")
    select cmd in "${commands[@]}"; do
        case $cmd in
            "Cancel")
                nine_of_clubs_menu
                ;;
            *)
                if [[ -n $cmd ]]; then
                    path=$(which "$cmd" 2>/dev/null)
                    if [[ -z $path ]]; then
                        echo -e "${CYAN}Executable for '$cmd' not found.${RESET}"
                    else
                        echo -e "${CYAN}Executable for '$cmd' is located at: $path${RESET}"
                    fi
                fi
                break
                ;;
        esac
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_clubs_menu
}

# Option 2: View All Executable Commands in PATH
list_executables() {
    clear
    echo -e "${CYAN}Listing all executable commands in your PATH:${RESET}"
    IFS=: read -ra dirs <<< "$PATH"
    for dir in "${dirs[@]}"; do
        if [[ -d $dir ]]; then
            echo -e "${CYAN}From directory: $dir${RESET}"
            ls "$dir"
        fi
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_clubs_menu
}

# Option 3: Exit Script
exit_script() {
    clear
    exit 0
}

nine_of_clubs_menu
