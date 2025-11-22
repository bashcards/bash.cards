#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Predefined commands for manual lookup
available_commands=(
    "ls" "cd" "pwd" "mkdir" "cp" "mv" "rm" "rmdir"
    "touch" "cat" "nano" "head" "tail" "chmod" "chown"
    "find" "locate" "alias" "unalias" "history" "man"
    "ps" "top" "uptime" "whoami" "date" "df" "free"
    "hostname" "who" "su" "sudo" "groups" "id"
    "kill" "ping" "tar" "gzip" "gunzip" "curl" "wget"
    "scp" "rsync" "echo" "sleep" "time" "basename" "dirname"
    "env" "export" "unset" "grep" "sed" "awk" "sort"
    "uniq" "cut" "diff" "cmp" "wc" "tr"
)

# Display the Ace of Clubs Menu
ace_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Ace of Clubs                               |"
    echo "     |                    View the Manual for a Command                        |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides access to manual pages for common Linux commands.   |"
    echo "     |  Use this interface to select a command and view its manual.            |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"

    # Display commands in three columns
    local total=${#available_commands[@]}
    local third=$((total / 3 + (total % 3 > 0 ? 1 : 0)))
    for i in $(seq 1 $third); do
        local left="${available_commands[$((i - 1))]:-}"
        local middle="${available_commands[$((i + third - 1))]:-}"
        local right="${available_commands[$((i + 2 * third - 1))]:-}"
        printf "     |     %-3d. %-15s %-3d. %-15s %-3d. %-20s |\n" \
            "$i" "$left" "$((i + third))" "$middle" "$((i + 2 * third))" "$right"
    done

    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Select a command to view its manual or scan 'q' to quit.               |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice

    if [[ $choice == "q" ]]; then
        exit 0
    elif [[ $choice -ge 1 && $choice -le $total ]]; then
        show_manual "${available_commands[$((choice - 1))]}"
    else
        echo "Invalid choice. Try again."
        sleep 1
        ace_of_clubs_menu
    fi
}

# Show the manual for the selected command
show_manual() {
    local command=$1
    clear
    echo -e "${CYAN}Displaying manual for command: ${command}${RESET}"
    if man "$command" &>/dev/null; then
        man "$command" | less
    else
        echo "No manual entry found for ${command}."
        sleep 2
    fi
    ace_of_clubs_menu
}

ace_of_clubs_menu
