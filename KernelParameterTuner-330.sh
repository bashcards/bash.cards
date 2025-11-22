#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

tune_kernel_parameters() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                     Eight of Clubs: Kernel Parameter Tuner                |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This tool allows you to view and modify kernel parameters in real-time.   |"
    echo "    | Options include viewing current parameters, testing changes, and more.    |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. View all current kernel parameters                                    |"
    echo "    |  2. Search for a specific parameter                                       |"
    echo "    |  3. Modify a kernel parameter temporarily                                 |"
    echo "    |  4. Modify a kernel parameter permanently                                 |"
    echo "    |  5. Reset parameters to default values                                    |"
    echo "    |  6. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Displaying all current kernel parameters..."
            sysctl -a | less
            ;;
        2)
            read -p "Enter a parameter keyword to search for: " param
            echo "Searching for parameter '$param'..."
            sysctl -a | grep -i "$param"
            ;;
        3)
            read -p "Enter the parameter to modify (e.g., net.ipv4.ip_forward): " param
            read -p "Enter the new value: " value
            sysctl -w "$param=$value"
            echo "Temporary change applied: $param = $value"
            ;;
        4)
            read -p "Enter the parameter to modify (e.g., net.ipv4.ip_forward): " param
            read -p "Enter the new value: " value
            echo "$param = $value" >> /etc/sysctl.conf
            sysctl -p
            echo "Permanent change applied: $param = $value"
            ;;
        5)
            echo "Resetting kernel parameters to default values..."
            cp /etc/sysctl.conf /etc/sysctl.conf.bak
            echo > /etc/sysctl.conf
            sysctl -p
            echo "Parameters reset. Original file backed up as /etc/sysctl.conf.bak."
            ;;
        6)
            echo "Exiting Kernel Parameter Tuner."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure `sysctl` command is available
if ! command -v sysctl &> /dev/null; then
    echo "Error: Required command 'sysctl' is not available. Ensure your system has it installed."
    exit 1
fi

# Main script execution
tune_kernel_parameters
clear
