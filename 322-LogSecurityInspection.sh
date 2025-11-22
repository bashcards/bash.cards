#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Function to inspect logs for security breaches
inspect_logs() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                  King of Spades: Log Security Inspection                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides options to inspect logs for potential security issues. |"
    echo "    | Select an option to analyze logs:                                         |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    |  1. Inspect authentication logs (/var/log/auth.log)                       |"
    echo "    |  2. Analyze system logs (/var/log/syslog)                                 |"
    echo "    |  3. Check failed SSH login attempts                                       |"
    echo "    |  4. Analyze firewall logs (/var/log/ufw.log)                              |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            if [ -f /var/log/auth.log ]; then
                clear
                echo "Analyzing authentication logs..."
                grep -i "failed\|error\|denied" /var/log/auth.log | tail -n 20
            else
                echo "/var/log/auth.log not found."
            fi
            ;;
        2)
            if [ -f /var/log/syslog ]; then
                clear
                echo "Analyzing system logs..."
                grep -i "failed\|error\|warning" /var/log/syslog | tail -n 20
            else
                echo "/var/log/syslog not found."
            fi
            ;;
        3)
            if [ -f /var/log/auth.log ]; then
                clear
                echo "Checking failed SSH login attempts..."
                grep -i "failed password" /var/log/auth.log | tail -n 20
            else
                echo "/var/log/auth.log not found."
            fi
            ;;
        4)
            if [ -f /var/log/ufw.log ]; then
                clear
                echo "Analyzing firewall logs..."
                grep -i "blocked\|denied" /var/log/ufw.log | tail -n 20
            else
                echo "/var/log/ufw.log not found."
            fi
            ;;
        5)
            echo "Exiting log inspection."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Main script execution
inspect_logs
clear
