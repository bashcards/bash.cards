#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Four of Diamonds Card
four_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                             Four of Diamonds                            |"
    echo "     |                     Dump Memory from Running Processes                  |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides tools to analyze and dump memory from active        |"
    echo "     |  processes, allowing forensic or reverse engineering investigation.     |"
    echo "     |                                                                         |"
    echo "     |  1. List Running Processes                                              |"
    echo "     |  2. Dump Memory of a Process                                            |"
    echo "     |  3. View Dumped Files                                                   |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) list_processes ;;
        2) dump_memory ;;
        3) view_dumps ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; four_of_diamonds_menu ;;
    esac
}

# List running processes
list_processes() {
    clear
    echo -e "${CYAN}Listing running processes...${RESET}"
    ps aux | less
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# Dump memory of a process
dump_memory() {
    clear
    echo -e "${CYAN}Dumping memory of a process...${RESET}"
    if command -v gcore &>/dev/null; then
        read -p "Enter the PID of the process to dump: " pid
        read -p "Enter the filename for the dump (e.g., dumpfile): " filename
        if [[ -d /proc/$pid ]]; then
            sudo gcore -o "$filename" "$pid"
            echo -e "${CYAN}Memory dump saved as ${filename}.${RESET}"
        else
            echo -e "${CYAN}Error: Process with PID $pid does not exist.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: gcore is not installed.${RESET}"
        echo "Please install gcore using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

# View dumped files
view_dumps() {
    clear
    echo -e "${CYAN}Viewing dumped files in the current directory...${RESET}"
    ls -lh | grep "core" || echo "No dump files found in the current directory."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    four_of_diamonds_menu
}

four_of_diamonds_menu
