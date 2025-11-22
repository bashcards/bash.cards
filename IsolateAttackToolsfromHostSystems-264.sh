#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Ten of Clubs Card
ten_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                               Ten of Clubs                               |"
    echo "     |                     Isolate Attack Tools from Host Systems               |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to safely isolate tools or scripts in controlled   |"
    echo "     |  environments to protect host systems from unintended consequences.      |"
    echo "     |                                                                         |"
    echo "     |  1. Create an Isolated Environment with Docker                          |"
    echo "     |  2. Create a Virtual Machine (VM) for Isolation                         |"
    echo "     |  3. Launch Attack Tools in a Sandbox                                    |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_docker_environment ;;
        2) create_virtual_machine ;;
        3) launch_in_sandbox ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; ten_of_clubs_menu ;;
    esac
}

# Create an Isolated Environment with Docker
create_docker_environment() {
    clear
    echo -e "${CYAN}Creating an isolated environment with Docker...${RESET}"
    if command -v docker &>/dev/null; then
        read -p "Enter the Docker image to use (e.g., kali-linux): " image
        docker run -it --rm "$image"
        echo "Exited Docker container."
    else
        echo "Error: Docker is not installed. Please install Docker first."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Create a Virtual Machine (VM) for Isolation
create_virtual_machine() {
    clear
    echo -e "${CYAN}Creating a virtual machine for isolation...${RESET}"
    if command -v vboxmanage &>/dev/null; then
        read -p "Enter the VM name to create or use: " vm_name
        VBoxManage createvm --name "$vm_name" --register
        VBoxManage modifyvm "$vm_name" --memory 2048 --cpus 2
        VBoxManage startvm "$vm_name"
        echo "Virtual Machine $vm_name started."
    else
        echo "Error: VirtualBox is not installed. Please install VirtualBox first."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

# Launch Attack Tools in a Sandbox
launch_in_sandbox() {
    clear
    echo -e "${CYAN}Launching attack tools in a sandbox...${RESET}"
    if command -v firejail &>/dev/null; then
        read -p "Enter the command to sandbox (e.g., nmap): " command
        firejail --quiet $command
        echo "Command $command executed in a sandbox."
    else
        echo "Error: Firejail is not installed. Please install Firejail first."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    ten_of_clubs_menu
}

ten_of_clubs_menu
