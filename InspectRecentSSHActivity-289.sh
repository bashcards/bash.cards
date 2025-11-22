#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

inspect_ssh_activity() {
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                               Nine of Hearts                             |"
        echo "    |                       Inspect Recent SSH Activity                        |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. Check /var/log/auth.log for SSH connections                          |"
        echo "    |  2. Check /var/log/secure for SSH connections                            |"
        echo "    |  3. Use lastlog to view recent SSH logins                                |"
        echo "    |  4. Check active SSH sessions with who or w                              |"
        echo "    |  5. Exit to main menu                                                    |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Inspecting /var/log/auth.log for recent SSH activity:${RESET}"
                if [ -f /var/log/auth.log ]; then
                    grep "sshd" /var/log/auth.log || echo "No SSH activity found in /var/log/auth.log."
                else
                    echo "/var/log/auth.log not found. This log may not exist on your system."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                clear
                echo -e "${CYAN}Inspecting /var/log/secure for recent SSH activity:${RESET}"
                if [ -f /var/log/secure ]; then
                    grep "sshd" /var/log/secure || echo "No SSH activity found in /var/log/secure."
                else
                    echo "/var/log/secure not found. This log may not exist on your system."
                fi
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                clear
                echo -e "${CYAN}Viewing recent SSH logins with lastlog:${RESET}"
                lastlog -u $(whoami) || echo "No recent SSH logins found."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            4)
                clear
                echo -e "${CYAN}Checking active SSH sessions with who and w:${RESET}"
                echo "Current SSH sessions (using 'who'):"
                who | grep "pts" || echo "No active SSH sessions found."
                echo -e "\nCurrent activity (using 'w'):"
                w || echo "No active sessions found."
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            5)
                echo "Exiting to main menu..."
                break
                ;;
            *)
                echo "Invalid choice. Please try again."
                read -n 1 -s -r -p "Press any key to continue..."
                ;;
        esac
    done
}

inspect_ssh_activity
