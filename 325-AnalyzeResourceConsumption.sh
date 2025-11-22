#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_resource_consumption() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |               Three of Clubs: Analyze Resource Consumption                |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides multiple options for analyzing resource consumption.   |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Launch 'htop' for a detailed view of running processes                |"
    echo "    |  2. View disk usage summary                                               |"
    echo "    |  3. Analyze network connections                                           |"
    echo "    |  4. Monitor CPU and memory utilization                                    |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            if command -v htop > /dev/null; then
                echo "Launching 'htop'. Press 'q' to exit."
                htop
            else
                echo "'htop' is not installed. Would you like to install it? (y/n)"
                read -n 1 install_choice
                if [ "$install_choice" = "y" ]; then
                    sudo apt update && sudo apt install -y htop
                    htop
                else
                    echo "Skipping installation of 'htop'."
                fi
            fi
            ;;
        2)
            echo "Displaying Disk Usage Summary:"
            df -h
            ;;
        3)
            echo "Analyzing Network Connections:"
            netstat -tunapl | less
            ;;
        4)
            echo "Monitoring CPU and Memory Utilization:"
            vmstat 1 5
            ;;
        5)
            echo "Exiting resource consumption analysis."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure required commands are available
for cmd in df netstat vmstat; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
analyze_resource_consumption
clear
