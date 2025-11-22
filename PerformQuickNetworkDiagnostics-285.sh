#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function for quick network diagnostics
network_diagnostics() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     ___________________________________________________________________________"
        echo "    |                             Five of Hearts                                |"
        echo "    |                     Perform Quick Network Diagnostics                     |"
        echo "    |___________________________________________________________________________|"
        echo "    |                                                                           |"
        echo "    | Choose an option:                                                         |"
        echo "    | 1. Check open ports on the system.                                        |"
        echo "    | 2. Ping a specific IP address or hostname.                                |"
        echo "    | 3. Perform a traceroute to a specific IP address or hostname.             |"
        echo "    | 4. Test DNS resolution for a domain.                                      |"
        echo "    | 5. Return to main menu.                                                   |"
        echo "    |___________________________________________________________________________|"
        echo "    |                                                                           |"
        echo "    |                            Enter your choice:                             |"
        echo "    |___________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                echo "Checking open ports using netstat..."
                sudo netstat -tuln | grep LISTEN || echo "No open ports found."
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            2)
                read -p "Enter the IP address or hostname to ping: " ping_target
                if [[ -n "$ping_target" ]]; then
                    echo "Pinging $ping_target..."
                    ping -c 4 "$ping_target" || echo "Ping failed."
                else
                    echo "No target entered."
                fi
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            3)
                read -p "Enter the IP address or hostname to traceroute: " trace_target
                if [[ -n "$trace_target" ]]; then
                    echo "Performing traceroute to $trace_target..."
                    traceroute "$trace_target" || echo "Traceroute failed."
                else
                    echo "No target entered."
                fi
                echo "Press any key to return to the menu..."
                read -n 1 -s -r
                ;;
            4)
                read -p "Enter the domain to test DNS resolution: " domain
                if [[ -n "$domain" ]]; then
                    echo "Resolving DNS for $domain..."
                    nslookup "$domain" || echo "DNS resolution failed."
                else
                    echo "No domain entered."
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
network_diagnostics
