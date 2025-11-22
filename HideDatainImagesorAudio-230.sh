#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Three of Diamonds Card
three_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                             Three of Diamonds                            |"
    echo "     |                Hide Data in Images or Audio Files (Steganography)        |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides an interface for using steganography to conceal      |"
    echo "     |  data within image or audio files using tools like steghide.             |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Hide Data in a File                                                  |"
    echo "     |  2. Extract Hidden Data from a File                                      |"
    echo "     |  3. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) hide_data ;;
        2) extract_data ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; three_of_diamonds_menu ;;
    esac
}

# Hide data in an image or audio file
hide_data() {
    clear
    echo -e "${CYAN}Hiding Data in a File...${RESET}"
    if command -v steghide &>/dev/null; then
        read -p "Enter the path to the file (image/audio) to embed data in: " file
        read -p "Enter the path to the data file to hide: " data
        read -p "Enter a password for encryption: " -s password
        echo
        steghide embed -ef "$data" -cf "$file" -p "$password"
        if [[ $? -eq 0 ]]; then
            echo -e "${CYAN}Data successfully hidden in $file.${RESET}"
        else
            echo -e "${CYAN}Error: Failed to hide data.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: steghide is not installed.${RESET}"
        echo "Please install steghide using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

# Extract hidden data from an image or audio file
extract_data() {
    clear
    echo -e "${CYAN}Extracting Hidden Data from a File...${RESET}"
    if command -v steghide &>/dev/null; then
        read -p "Enter the path to the file containing hidden data: " file
        read -p "Enter the output file for the extracted data: " output
        read -p "Enter the password for decryption: " -s password
        echo
        steghide extract -sf "$file" -xf "$output" -p "$password"
        if [[ $? -eq 0 ]]; then
            echo -e "${CYAN}Data successfully extracted to $output.${RESET}"
        else
            echo -e "${CYAN}Error: Failed to extract data.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: steghide is not installed.${RESET}"
        echo "Please install steghide using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    three_of_diamonds_menu
}

three_of_diamonds_menu
