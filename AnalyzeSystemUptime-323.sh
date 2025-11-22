#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

analyze_uptime() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                      Ace of Clubs: Analyze System Uptime                  |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides detailed information about system uptime, load,        |"
    echo "    | and connected user sessions.                                              |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. View current uptime                                                   |"
    echo "    |  2. Analyze load averages                                                 |"
    echo "    |  3. View uptime history from logs                                         |"
    echo "    |  4. Display currently logged-in users                                     |"
    echo "    |  5. Monitor system uptime in real-time                                    |"
    echo "    |  6. Check for high system load conditions                                 |"
    echo "    |  7. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Current System Uptime:"
            uptime
            ;;
        2)
            echo "Analyzing Load Averages:"
            echo "Load averages indicate the number of processes waiting to run."
            echo "Short-term (1 min), Medium-term (5 min), Long-term (15 min):"
            uptime | awk -F'load average:' '{ print $2 }'
            ;;
        3)
            echo "Viewing Uptime History from Logs:"
            if [ -f /var/log/wtmp ]; then
                echo "System uptime history:"
                last reboot | head -n 10
            else
                echo "No uptime logs available in /var/log/wtmp."
            fi
            ;;
        4)
            echo "Currently Logged-in Users:"
            who
            ;;
        5)
            echo "Monitoring System Uptime in Real-Time. Press Ctrl+C to stop."
            watch -n 1 uptime
            ;;
        6)
            echo "Checking for High System Load:"
            load=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)
            cores=$(nproc)
            if (( $(echo "$load > $cores" | bc -l) )); then
                echo "Warning: High system load detected!"
                echo "Load average: $load, CPU cores: $cores"
            else
                echo "System load is normal."
                echo "Load average: $load, CPU cores: $cores"
            fi
            ;;
        7)
            echo "Exiting the uptime analysis tool."
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
for cmd in uptime last who watch nproc bc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
analyze_uptime
clear
