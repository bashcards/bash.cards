#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Five of Clubs Card
five_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Five of Clubs                              |"
    echo "     |                  Run Secure Anonymous Operating Systems                 |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides options to install, configure, and run Whonix,      |"
    echo "     |  a secure operating system focused on anonymity and privacy.            |"
    echo "     |                                                                         |"
    echo "     |  1. Download Whonix Virtual Machine Images                              |"
    echo "     |  2. Import Whonix Images into VirtualBox                                |"
    echo "     |  3. Start Whonix Gateway and Workstation                                |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) download_whonix ;;
        2) import_whonix ;;
        3) start_whonix ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; five_of_clubs_menu ;;
    esac
}

# Download Whonix Virtual Machine Images
download_whonix() {
    clear
    echo -e "${CYAN}Downloading Whonix Virtual Machine Images...${RESET}"
    if command -v curl &>/dev/null; then
        curl -O https://www.whonix.org/wiki/VirtualBox/XFCE
        echo "Whonix Virtual Machine images have been downloaded to the current directory."
    else
        echo "Error: curl is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_clubs_menu
}

# Import Whonix Images into VirtualBox
import_whonix() {
    clear
    echo -e "${CYAN}Importing Whonix Images into VirtualBox...${RESET}"
    if command -v vboxmanage &>/dev/null; then
        echo "Please specify the path to the Whonix Gateway image:"
        read -p "Gateway Image Path: " gateway_path
        echo "Please specify the path to the Whonix Workstation image:"
        read -p "Workstation Image Path: " workstation_path

        vboxmanage import "$gateway_path" --vsys 0 --vmname "Whonix-Gateway"
        vboxmanage import "$workstation_path" --vsys 0 --vmname "Whonix-Workstation"

        echo "Whonix Gateway and Workstation images imported successfully."
    else
        echo "Error: VirtualBox is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_clubs_menu
}

# Start Whonix Gateway and Workstation
start_whonix() {
    clear
    echo -e "${CYAN}Starting Whonix Gateway and Workstation...${RESET}"
    if command -v vboxmanage &>/dev/null; then
        vboxmanage startvm "Whonix-Gateway" --type headless
        vboxmanage startvm "Whonix-Workstation" --type gui
        echo "Whonix Gateway and Workstation started successfully."
    else
        echo "Error: VirtualBox is not installed. Please install it and try again."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    five_of_clubs_menu
}

five_of_clubs_menu
