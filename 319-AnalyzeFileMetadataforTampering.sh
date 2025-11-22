#!/bin/bash

CYAN='\033[1;36m'
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

analyze_metadata() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                             Jack of Spades                               |"
        echo "    |                  Analyze File Metadata for Tampering                     |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. View detailed file metadata                                          |"
        echo "    |  2. Compare file metadata against a baseline                             |"
        echo "    |  3. Search for recently modified files                                   |"
        echo "    |  4. Check file hashes for tampering                                      |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                read -p "Enter the path of the file to analyze: " filepath
                clear
                if [ -e "$filepath" ]; then
                    echo -e "${CYAN}File Metadata for $filepath:${RESET}"
                    stat "$filepath"
                else
                    echo -e "${RED}File not found: $filepath${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter the path of the file to compare: " filepath
                read -p "Enter the path of the baseline file: " baseline
                clear
                if [ -e "$filepath" ] && [ -e "$baseline" ]; then
                    echo -e "${CYAN}Comparing metadata between $filepath and $baseline:${RESET}"
                    diff <(stat "$filepath") <(stat "$baseline")
                else
                    echo -e "${RED}One or both files not found.${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                read -p "Enter the directory to search: " dirpath
                read -p "Enter the time period (e.g., '-1day', '-2hour'): " timeperiod
                clear
                if [ -d "$dirpath" ]; then
                    echo -e "${CYAN}Recently modified files in $dirpath:${RESET}"
                    find "$dirpath" -type f -mtime "$timeperiod"
                else
                    echo -e "${RED}Directory not found: $dirpath${RESET}"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                read -p "Enter the path of the file to hash: " filepath
                read -p "Enter the known hash for comparison (leave blank to skip): " known_hash
                clear
                if [ -e "$filepath" ]; then
                    file_hash=$(sha256sum "$filepath" | awk '{print $1}')
                    echo -e "${CYAN}SHA-256 Hash of $filepath:${RESET} $file_hash"
                    if [ -n "$known_hash" ]; then
                        if [ "$file_hash" == "$known_hash" ]; then
                            echo -e "${GREEN}Hashes match! No tampering detected.${RESET}"
                        else
                            echo -e "${RED}Hashes do not match! File may be tampered with.${RESET}"
                        fi
                    fi
                else
                    echo -e "${RED}File not found: $filepath${RESET}"
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

analyze_metadata
