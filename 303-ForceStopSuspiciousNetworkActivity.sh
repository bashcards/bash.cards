#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to force stop suspicious network activity
force_stop_network_activity() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________________________________________"
        echo "    |                             Four of Hearts                                |"
        echo "    |                    Force Stop Suspicious Network Activity                 |"
        echo "    |___________________________________________________________________________|"
        echo "    |                                                                           |"
        echo "    | Choose an option to stop suspicious network activity:                     |"
        echo "    | 1. List active connections with netstat.                                  |"
        echo "    | 2. Kill a process using its PID.                                          |"
        echo "    | 3. Block an IP address using iptables.                                    |"
        echo "    | 4. Stop network activity for a specific user.                             |"
        echo "    | 5. Return to main menu.                                                   |"
        echo "    |___________________________________________________________________________|"
        echo "    |                                                                           |"
        echo "    |                            Enter your choice:                             |"
        echo "    |___________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                echo "Listing active network connections..."
                netstat -tunp || echo "Netstat not available. Try ss as an alternative."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            2)
                echo "Listing processes with active network connections..."
                netstat -tunp | awk '{print $7}' | grep -o '[0-9]*/.*' | sed 's/\///g' | sort -u
                read -p "Enter the PID of the process to kill: " pid
                if [[ -n "$pid" && "$pid" =~ ^[0-9]+$ ]]; then
                    echo "Attempting to kill process with PID $pid..."
                    sudo kill -9 "$pid" && echo "Process $pid terminated." || echo "Failed to kill process $pid."
                else
                    echo "Invalid PID entered."
                fi
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            3)
                read -p "Enter the IP address to block: " ip_address
                if [[ -n "$ip_address" ]]; then
                    echo "Blocking IP address $ip_address using iptables..."
                    sudo iptables -A INPUT -s "$ip_address" -j DROP && echo "IP $ip_address blocked." || echo "Failed to block IP $ip_address."
                else
                    echo "No IP address entered."
                fi
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            4)
                read -p "Enter the username to stop network activity for: " username
                if id "$username" &>/dev/null; then
                    echo "Stopping all processes for user $username..."
                    pkill -u "$username" && echo "All processes for $username have been terminated." || echo "Failed to terminate processes for $username."
                else
                    echo "User $username does not exist."
                fi
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            5)
                break
                ;;
            *)
                echo "Invalid choice. Please select a valid option."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
        esac
    done
    clear
}

# Run the function for the card
force_stop_network_activity
