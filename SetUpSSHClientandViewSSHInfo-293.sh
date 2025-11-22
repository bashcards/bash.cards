#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

setup_ssh_client() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                                King of Hearts                            |"
        echo "    |                       Set Up SSH Client and View SSH Info                |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Configure SSH client settings                                        |"
        echo "    |  2. View SSH connection history                                          |"
        echo "    |  3. Test SSH connection                                                  |"
        echo "    |  4. Generate new SSH key pair                                            |"
        echo "    |  5. View existing SSH key                                                |"
        echo "    |  6. Return to main menu                                                  |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Configuring SSH client settings...${RESET}"
                echo "Checking for SSH configuration file..."
                config_file="$HOME/.ssh/config"
                if [ ! -f "$config_file" ]; then
                    echo "No SSH config file found. Creating one..."
                    mkdir -p "$HOME/.ssh"
                    touch "$config_file"
                fi
                echo "Opening SSH configuration file for editing..."
                nano "$config_file"
                ;;
            2)
                clear
                echo -e "${CYAN}Viewing SSH connection history...${RESET}"
                if [ -f /var/log/auth.log ]; then
                    echo "Displaying recent SSH logins from /var/log/auth.log:"
                    grep "sshd" /var/log/auth.log | tail -n 20
                elif [ -d /var/log/journal ]; then
                    echo "Displaying recent SSH logins from journal logs:"
                    journalctl -u ssh | tail -n 20
                else
                    echo "No SSH logs found."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Testing SSH connection...${RESET}"
                read -p "Enter SSH host (user@hostname): " ssh_host
                echo "Attempting to connect to $ssh_host..."
                ssh -q -o BatchMode=yes -o ConnectTimeout=5 "$ssh_host" exit
                if [ $? -eq 0 ]; then
                    echo "SSH connection to $ssh_host is successful!"
                else
                    echo "Failed to connect to $ssh_host. Check credentials or connectivity."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Generating a new SSH key pair...${RESET}"
                ssh-keygen -t rsa -b 2048 -f "$HOME/.ssh/id_rsa" -N ""
                echo "New SSH key pair generated successfully!"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                clear
                echo -e "${CYAN}Viewing existing SSH public key...${RESET}"
                if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
                    echo "Here is your SSH public key:"
                    cat "$HOME/.ssh/id_rsa.pub"
                else
                    echo "No SSH public key found. Generate one first!"
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            6)
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

setup_ssh_client
