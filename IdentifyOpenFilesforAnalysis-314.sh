#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
RESET='\033[0m'

identify_open_files() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                             Seven of Spades                              |"
        echo "    |                      Identify Open Files for Analysis                    |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. View all open files                                                  |"
        echo "    |  2. Filter by specific process (PID)                                     |"
        echo "    |  3. Filter by specific user                                              |"
        echo "    |  4. Filter by specific file name                                         |"
        echo "    |  5. Search for deleted files still open                                  |"
        echo "    |  6. Monitor open files in real-time                                      |"
        echo "    |  7. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing all open files...${RESET}"
                sudo lsof | less
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter the Process ID (PID): " pid
                clear
                echo -e "${CYAN}Listing open files for process with PID $pid...${RESET}"
                sudo lsof -p "$pid" | less
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                read -p "Enter the username: " user
                clear
                echo -e "${CYAN}Listing open files for user $user...${RESET}"
                sudo lsof -u "$user" | less
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                read -p "Enter the file name or part of it: " file
                clear
                echo -e "${CYAN}Searching for open files containing '$file'...${RESET}"
                sudo lsof | grep "$file" | less
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Searching for deleted files still open...${RESET}"
                sudo lsof | grep '(deleted)' | less
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
                clear
                echo -e "${CYAN}Monitoring open files in real-time... (Press Ctrl+C to stop)${RESET}"
                sudo lsof -r 2
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            7)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo -e "${RED}Invalid choice. Please try again.${RESET}"
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

identify_open_files
