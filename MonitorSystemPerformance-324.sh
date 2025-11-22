#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

monitor_system_performance() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                     Two of Clubs: Monitor System Performance              |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides various options to monitor and analyze system          |"
    echo "    | performance in real-time.                                                 |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Launch 'top' for real-time system monitoring                          |"
    echo "    |  2. View CPU usage details                                                |"
    echo "    |  3. Display memory usage details                                          |"
    echo "    |  4. Monitor disk I/O performance                                          |"
    echo "    |  5. Check network utilization                                             |"
    echo "    |  6. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Launching 'top' for real-time system monitoring. Press 'q' to exit."
            top
            ;;
        2)
            echo "Displaying CPU Usage Details:"
            mpstat -P ALL 1 5
            ;;
        3)
            echo "Displaying Memory Usage Details:"
            free -h
            ;;
        4)
            echo "Monitoring Disk I/O Performance:"
            iostat -xz 1 5
            ;;
        5)
            echo "Checking Network Utilization:"
            if [ -x "$(command -v iftop)" ]; then
                echo "Launching 'iftop' for network monitoring. Press 'q' to exit."
                iftop
            else
                echo "'iftop' is not installed. Would you like to install it? (y/n)"
                read -n 1 install_choice
                if [ "$install_choice" = "y" ]; then
                    sudo apt update && sudo apt install -y iftop
                    iftop
                else
                    echo "Skipping installation of 'iftop'."
                fi
            fi
            ;;
        6)
            echo "Exiting system performance monitoring tool."
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
for cmd in top mpstat free iostat; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
monitor_system_performance
clear
