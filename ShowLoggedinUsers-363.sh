# only # 3 works
#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the King of Diamonds Card
king_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              King of Diamonds                           |"
    echo "     |                           Show Logged-in Users                          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card provides advanced functionality to monitor and analyze       |"
    echo "     |  logged-in users and their activity.                                    |"
    echo "     |                                                                         |"
    echo "     |  1. View all logged-in users                                            |"
    echo "     |  2. Show detailed session info for all users                            |"
    echo "     |  3. View user activity summary                                          |"
    echo "     |  4. Set an alert for suspicious activity                                |"
    echo "     |  5. Log detailed session info to a file                                 |"
    echo "     |  6. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_all_users ;;
        2) detailed_session_info ;;
        3) user_activity_summary ;;
        4) set_alert ;;
        5) log_session_info ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_diamonds_menu ;;
    esac
}

# View all logged-in users
view_all_users() {
    clear
    echo -e "${CYAN}Logged-in Users:${RESET}"
    who
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# Show detailed session info for all users
detailed_session_info() {
    clear
    echo -e "${CYAN}Detailed Session Information:${RESET}"
    who -a
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# View user activity summary
user_activity_summary() {
    clear
    echo -e "${CYAN}User Activity Summary:${RESET}"
    echo "Total Logged-In Users: $(who | wc -l)"
    echo "Unique Users Logged In: $(who | awk '{print $1}' | sort | uniq | wc -l)"
    echo -e "\nUser Sessions:"
    who | awk '{print $1}' | sort | uniq -c | sort -nr
    echo -e "\nRecent Commands Executed by Users:"
    lastcomm=$(last -n 10)
    if [[ -n "$lastcomm" ]]; then
        echo "$lastcomm"
    else
        echo "No recent commands found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# Set an alert for suspicious activity
set_alert() {
    clear
    echo -e "${CYAN}Set Alert for Suspicious Activity:${RESET}"
    echo "This feature monitors login frequency and flags users exceeding a threshold."
    read -p "Enter login frequency threshold (e.g., 5): " threshold
    flagged_users=$(who | awk '{print $1}' | sort | uniq -c | awk -v t="$threshold" '$1 > t {print $2}')
    if [[ -n "$flagged_users" ]]; then
        echo "Alert! The following users exceeded the threshold:"
        echo "$flagged_users"
    else
        echo "No suspicious activity detected."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

# Log detailed session info to a file
log_session_info() {
    clear
    log_file="session_info_$(date +%Y%m%d%H%M%S).log"
    echo -e "${CYAN}Logging session information to $log_file...${RESET}"
    who -a > "$log_file"
    echo "Session information logged."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_diamonds_menu
}

king_of_diamonds_menu

