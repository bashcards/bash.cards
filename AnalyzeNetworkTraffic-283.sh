#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_network_traffic() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "      __________________________________________________________________________"
        echo "     |                                Two of Hearts                             |"
        echo "     |                           Analyze Network Traffic                        |"
        echo "     |__________________________________________________________________________|"
        echo "     |                                                                          |"
        echo "     |  Select an option to analyze network traffic:                            |"
        echo "     |                                                                          |"
        echo "     |  1. Capture packets on a specific interface                              |"
        echo "     |  2. Filter traffic by port number                                        |"
        echo "     |  3. View all HTTP traffic                                                |"
        echo "     |  4. Analyze traffic to/from a specific IP address                        |"
        echo "     |  5. Exit                                                                 |"
        echo "     |__________________________________________________________________________|"
        echo "     |                                                                          |"
        echo "     |                            Enter your choice:                            |"
        echo "     |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Available network interfaces:${RESET}"
                ip -o link show | awk -F': ' '{print $2}'
                read -p "Enter the network interface to monitor: " interface
                if [ -z "$interface" ]; then
                    echo -e "${CYAN}No interface selected. Returning to menu...${RESET}"
                else
                    echo -e "${CYAN}Capturing packets on interface $interface. Press Ctrl+C to stop.${RESET}"
                    sudo tcpdump -i "$interface" -n
                fi
                ;;
            2)
                clear
                read -p "Enter the port number to filter traffic: " port
                if [[ "$port" =~ ^[0-9]+$ ]]; then
                    echo -e "${CYAN}Capturing traffic on port $port. Press Ctrl+C to stop.${RESET}"
                    sudo tcpdump -n port "$port"
                else
                    echo -e "${CYAN}Invalid port number. Returning to menu...${RESET}"
                fi
                ;;
            3)
                clear
                echo -e "${CYAN}Capturing HTTP traffic. Press Ctrl+C to stop.${RESET}"
                sudo tcpdump -n -A port 80
                ;;
            4)
                clear
                read -p "Enter the IP address to analyze traffic: " ip_address
                if [[ "$ip_address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                    echo -e "${CYAN}Capturing traffic to/from $ip_address. Press Ctrl+C to stop.${RESET}"
                    sudo tcpdump -n host "$ip_address"
                else
                    echo -e "${CYAN}Invalid IP address. Returning to menu...${RESET}"
                fi
                ;;
            5)
                clear
                echo -e "${CYAN}Exiting...${RESET}"
                exit 0
                ;;
            *)
                echo -e "${CYAN}Invalid choice. Try again.${RESET}"
                ;;
        esac
        echo -e "${CYAN}Press any key to return to the main menu...${RESET}"
        read -n 1 -s -r
    done
}

# Check if tcpdump is installed
if ! command -v tcpdump &>/dev/null; then
    echo -e "${CYAN}tcpdump is not installed. Installing it now...${RESET}"
    read -p "Do you want to proceed with the installation? (y/n): " install_choice
    if [[ "$install_choice" =~ ^[Yy]$ ]]; then
        sudo apt-get update && sudo apt-get install -y tcpdump
        echo -e "${CYAN}tcpdump installed successfully.${RESET}"
    else
        echo -e "${CYAN}tcpdump is required for this tool. Exiting.${RESET}"
        exit 1
    fi
fi

analyze_network_traffic
