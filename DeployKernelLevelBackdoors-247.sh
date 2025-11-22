#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Seven of Spades Card
seven_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Seven of Spades                            |"
    echo "     |                      Deploy Kernel-Level Backdoors                      |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides options to manage kernel-level modules for           |"
    echo "     |  persistence and stealth. These operations are for authorized            |"
    echo "     |  environments and testing only.                                          |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Load a kernel module                                                 |"
    echo "     |  2. Unload a kernel module                                               |"
    echo "     |  3. List all loaded kernel modules                                       |"
    echo "     |  4. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) load_kernel_module ;;
        2) unload_kernel_module ;;
        3) list_loaded_modules ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; seven_of_spades_menu ;;
    esac
}

# Load a kernel module
load_kernel_module() {
    clear
    echo -e "${CYAN}Loading a kernel module...${RESET}"
    read -p "Enter the path to the kernel module (e.g., /path/to/module.ko): " module_path
    if [[ -f "$module_path" ]]; then
        sudo insmod "$module_path" && echo -e "${CYAN}Kernel module loaded successfully.${RESET}" || echo -e "${CYAN}Failed to load the kernel module.${RESET}"
    else
        echo -e "${CYAN}Error: Kernel module not found at $module_path.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_spades_menu
}

# Unload a kernel module
unload_kernel_module() {
    clear
    echo -e "${CYAN}Unloading a kernel module...${RESET}"
    read -p "Enter the name of the kernel module to unload: " module_name
    sudo rmmod "$module_name" && echo -e "${CYAN}Kernel module $module_name unloaded successfully.${RESET}" || echo -e "${CYAN}Failed to unload kernel module $module_name.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_spades_menu
}

# List all loaded kernel modules
list_loaded_modules() {
    clear
    echo -e "${CYAN}Listing all loaded kernel modules...${RESET}"
    lsmod
    read -n 1 -s -r -p "Press any key to return to the menu..."
    seven_of_spades_menu
}

seven_of_spades_menu
