#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

generate_file_hashes() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                               Ace of Spades                              |"
        echo "    |                  Generate File Hashes for Integrity Verification         |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Hash a single file                                                   |"
        echo "    |  2. Hash all files in a directory                                        |"
        echo "    |  3. Verify file integrity against a hash file                            |"
        echo "    |  4. Install required tools (if not installed)                            |"
        echo "    |  5. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Hashing a single file...${RESET}"
                read -p "Enter the path to the file: " file_path
                if [ -f "$file_path" ]; then
                    echo "Generating hash for $file_path:"
                    sha256sum "$file_path"
                else
                    echo "File not found: $file_path"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Hashing all files in a directory...${RESET}"
                read -p "Enter the path to the directory: " dir_path
                if [ -d "$dir_path" ]; then
                    echo "Generating hashes for files in $dir_path:"
                    find "$dir_path" -type f -exec sha256sum {} +
                else
                    echo "Directory not found: $dir_path"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Verifying file integrity against a hash file...${RESET}"
                read -p "Enter the path to the hash file: " hash_file
                if [ -f "$hash_file" ]; then
                    echo "Verifying files using $hash_file:"
                    sha256sum -c "$hash_file"
                else
                    echo "Hash file not found: $hash_file"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Installing required tools...${RESET}"
                if ! command -v sha256sum &> /dev/null; then
                    echo "sha256sum is not installed. Installing coreutils..."
                    sudo apt-get update && sudo apt-get install -y coreutils
                else
                    echo "sha256sum is already installed."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                echo "Returning to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

generate_file_hashes
