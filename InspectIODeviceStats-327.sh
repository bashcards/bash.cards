#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

inspect_io_device_stats() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                 Five of Clubs: Inspect I/O Device Stats                   |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool provides options for monitoring and analyzing I/O statistics.   |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Display basic I/O stats (iostat)                                      |"
    echo "    |  2. Monitor I/O usage in real-time                                        |"
    echo "    |  3. Inspect I/O stats for individual devices                              |"
    echo "    |  4. View CPU usage and I/O activity                                       |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Basic I/O Stats:"
            iostat
            ;;
        2)
            echo "Real-Time I/O Monitoring:"
            echo "Press Ctrl+C to stop."
            iostat -x 1
            ;;
        3)
            echo "Enter the device name (e.g., sda, nvme0n1):"
            read -p "Device: " device
            if [ -n "$device" ]; then
                echo "I/O Stats for device $device:"
                iostat -x "$device"
            else
                echo "No device specified. Returning to menu..."
            fi
            ;;
        4)
            echo "CPU and I/O Activity:"
            iostat -c
            ;;
        5)
            echo "Exiting I/O stats viewer."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `iostat` is available
if ! command -v iostat &> /dev/null; then
    echo "Error: Required command 'iostat' is not available. Install it using 'sudo apt install sysstat' or equivalent for your distro."
    exit 1
fi

# Main script execution
inspect_io_device_stats
clear
