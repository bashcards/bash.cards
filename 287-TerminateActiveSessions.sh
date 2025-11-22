#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

terminate_sessions_menu() {
    clear
    while true; do
        clear
        echo -e "${CYAN}"
        echo "     __________________________________________________________________________"
        echo "    |                                Seven of Hearts                           |"
        echo "    |                          Terminate Active Sessions                       |"
        echo "    |__________________________________________________________________________|"
        echo "    |                                                                          |"
        echo "    |  Options:                                                                |"
        echo "    |  1. List all active sessions                                             |"
        echo "    |  2. Find sessions by username                                            |"
        echo "    |  3. Terminate a specific session                                         |"
        echo "    |  4. View processes for a specific user                                   |"
        echo "    |  5. Exit to main menu                                                    |"
        echo "    |__________________________________________________________________________|"
        echo -e "${RESET}"

        read -p "Enter your choice: " choice
        case $choice in
            1)
                clear
                echo -e "${CYAN}Listing all active sessions:${RESET}"
                who
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            2)
                read -p "Enter username to search for sessions: " user
                clear
                echo -e "${CYAN}Searching for sessions for user: $user${RESET}"
                who | grep -i "$user" || echo "No sessions found for user: $user"
                read -n 1 -s -r -p "Press any key to return to the menu..."
                ;;
            3)
                read -p "Enter the username to terminate the session: " user_choice
                if [[ -z "$user_choice" ]]; then
                    echo "No username entered. Returning to menu..."
                    read -n 1 -s -r -p "Press any key to continue..."
                else
                    echo "Attempting to terminate sessions for user: $user_choice"
                    session_pids=$(ps -u "$user_choice" -o pid=)
                    if [[ -z "$session_pids" ]]; then
                        echo "No active sessions found for user: $user_choice"
                    else
                        for pid in $session_pids; do
                            kill -9 "$pid" && echo "Terminated session with PID: $pid"
                        done
                        echo "All sessions for user $user_choice have been terminated."
                    fi
                    read -n 1 -s -r -p "Press any key to return to the menu..."
                fi
                ;;
            4)
                read -p "Enter username to view processes: " proc_user
                clear
                echo -e "${CYAN}Processes for user: $proc_user${RESET}"
                ps -u "$proc_user" || echo "No processes found for user: $proc_user"
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

terminate_sessions_menu
