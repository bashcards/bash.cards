#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

review_system_configurations() {
    clear
    echo -e "${CYAN}"
    echo "     ___________________________________________________________________________"
    echo "    |                King of Clubs: System Configuration Review                 |"
    echo "    |___________________________________________________________________________|"
    echo "    |                                                                           |"
    echo "    | This card provides advanced tools to review and analyze your system       |"
    echo "    | configurations for potential weaknesses and misconfigurations.            |"
    echo "    |                                                                           |"
    echo "    | Options:                                                                  |"
    echo "    |  1. Check for unused or unnecessary services                              |"
    echo "    |  2. Review open network ports and their associated services               |"
    echo "    |  3. Analyze file permissions on sensitive directories                     |"
    echo "    |  4. Detect weak passwords using PAM (Pluggable Authentication Module)     |"
    echo "    |  5. Exit                                                                  |"
    echo "    |___________________________________________________________________________|"
    echo -e "${RESET}"

    read -p "Enter your choice: " choice
    case $choice in
        1)
            echo "Checking for unused or unnecessary services..."
            systemctl list-unit-files --state=enabled | grep -E 'enabled|active'
            echo "Tip: Disable unused services with: sudo systemctl disable <service_name>"
            ;;
        2)
            echo "Reviewing open network ports and their associated services..."
            sudo netstat -tuln
            echo "Tip: Close unnecessary ports using firewall rules."
            ;;
        3)
            echo "Analyzing file permissions on sensitive directories..."
            sudo find /etc /var /root /home -type f -perm -o+w -exec ls -ld {} \;
            echo "Tip: Correct permissions using: chmod and chown commands."
            ;;
        4)
            echo "Detecting weak passwords using PAM..."
            if [ -f "/etc/shadow" ]; then
                sudo awk -F: '($2 == "") { print "Weak password for user: "$1 }' /etc/shadow
            else
                echo "Shadow file not found. Unable to analyze passwords."
            fi
            echo "Tip: Enforce strong passwords using PAM configuration in /etc/security."
            ;;
        5)
            echo "Exiting System Configuration Review."
            return
            ;;
        *)
            echo "Invalid choice. Returning to menu..."
            ;;
    esac

    echo "Press any key to return to the menu..."
    read -n 1 -s
}

# Ensure necessary commands are available
for cmd in systemctl netstat find awk; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' is not available. Install it and try again."
        exit 1
    fi
done

# Main script execution
review_system_configurations
clear
