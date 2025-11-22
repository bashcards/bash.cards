#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

inspect_disk_usage() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                              Ten of Spades                               |"
        echo "    |                       Inspect Unusual Disk Usage                         |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Show disk usage of current directory                                 |"
        echo "    |  2. Find top 10 largest files and directories                            |"
        echo "    |  3. Inspect disk usage by directory depth                                |"
        echo "    |  4. Check disk space usage for a specific directory                      |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Disk usage of the current directory:${RESET}"
                du -sh ./*
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Top 10 largest files and directories:${RESET}"
                du -ah / | sort -rh | head -n 10
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Disk usage by directory depth:${RESET}"
                du --max-depth=1 -h | sort -rh
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                read -p "Enter the path of the directory to inspect: " dirpath
                clear
                if [ -d "$dirpath" ]; then
                    echo -e "${CYAN}Disk usage for $dirpath:${RESET}"
                    du -sh "$dirpath"/*
                else
                    echo -e "${RED}Invalid directory: $dirpath${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
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

inspect_disk_usage
