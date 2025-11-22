#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Predefined shell built-in commands for help
builtin_commands=(
    "cd" "pwd" "echo" "alias" "unalias" "export" "unset"
    "read" "set" "trap" "shift" "exit" "break" "continue"
    "eval" "exec" "help" "history" "jobs" "fg" "bg" "kill"
    "wait" "umask" "test" "type" "times" "getopts"
)

# Display the Two of Clubs Menu
two_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Two of Clubs                               |"
    echo "     |                     Get Help for Shell Built-In Commands                |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides a lightweight interface for accessing help pages    |"
    echo "     |  for shell built-in commands.                                           |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"

    # Display commands in three columns
    local total=${#builtin_commands[@]}
    local third=$((total / 3 + (total % 3 > 0 ? 1 : 0)))
    for i in $(seq 1 $third); do
        local left="${builtin_commands[$((i - 1))]:-}"
        local middle="${builtin_commands[$((i + third - 1))]:-}"
        local right="${builtin_commands[$((i + 2 * third - 1))]:-}"
        printf "     |          %-3d. %-15s %-3d. %-15s %-3d. %-15s |\n" \
            "$i" "$left" "$((i + third))" "$middle" "$((i + 2 * third))" "$right"
    done

    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Select a command to view its help output or scan 'q' to quit.          |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice

    if [[ $choice == "q" ]]; then
        exit 0
    elif [[ $choice -ge 1 && $choice -le $total ]]; then
        show_help "${builtin_commands[$((choice - 1))]}"
    else
        echo "Invalid choice. Try again."
        sleep 1
        two_of_clubs_menu
    fi
}

# Show the help for the selected built-in command
show_help() {
    local command=$1
    clear
    echo -e "${CYAN}Displaying help for built-in command: ${command}${RESET}"
    if help "$command" &>/dev/null; then
        help "$command" | less
    else
        echo "No help available for ${command}."
        sleep 2
    fi
    two_of_clubs_menu
}

two_of_clubs_menu
