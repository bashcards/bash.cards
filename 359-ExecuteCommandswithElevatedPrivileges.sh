#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Nine of Diamonds Card
nine_of_diamonds_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Nine of Diamonds                           |"
    echo "     |           Manage and Execute Commands with Elevated Privileges          |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  1. Execute a predefined command                                        |"
    echo "     |  2. Execute a custom command                                            |"
    echo "     |  3. Manage user sudo privileges                                         |"
    echo "     |  4. View system logs requiring root access                              |"
    echo "     |  5. Schedule a privileged task                                          |"
    echo "     |  6. View current user and group details                                 |"
    echo "     |  7. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) execute_predefined_command ;;
        2) execute_custom_command ;;
        3) manage_sudo_privileges ;;
        4) view_system_logs ;;
        5) schedule_privileged_task ;;
        6) view_user_details ;;
        7) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; nine_of_diamonds_menu ;;
    esac
}

# Execute a predefined command
execute_predefined_command() {
    clear
    echo -e "${CYAN}Select a predefined command to execute:${RESET}"
    commands=(
        "apt update - Update package lists"
        "apt upgrade - Upgrade all packages"
        "systemctl status - View system service statuses"
        "systemctl restart - Restart a service"
        "reboot - Reboot the system"
        "shutdown now - Shut down the system"
        "df -h - View available disk space"
        "free -h - View memory usage"
    )
    select cmd in "${commands[@]}" "Cancel"; do
        if [[ $REPLY -gt 0 && $REPLY -le ${#commands[@]} ]]; then
            echo "Executing: sudo ${cmd%% -*}"
            sudo bash -c "${cmd%% -*}"
            break
        elif [[ $REPLY -eq $((${#commands[@]} + 1)) ]]; then
            echo "Cancelled."
            break
        else
            echo "Invalid choice. Try again."
        fi
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

# Execute a custom command
execute_custom_command() {
    clear
    read -p "Enter the command to run as sudo (e.g., apt update): " cmd
    echo "Executing: sudo $cmd"
    sudo bash -c "$cmd"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

# Manage sudo privileges for a user
manage_sudo_privileges() {
    clear
    echo -e "${CYAN}Manage user sudo privileges:${RESET}"
    echo "1. View current user's sudo privileges"
    echo "2. Add a user to the sudo group"
    echo "3. Remove a user from the sudo group"
    echo "4. Back to menu"
    read -p "Enter your choice: " choice
    case $choice in
        1) sudo -l; read -n 1 -s -r -p "Press any key to continue..." ;;
        2) read -p "Enter the username to add to the sudo group: " username
           sudo usermod -aG sudo "$username"
           echo "User $username added to the sudo group."
           ;;
        3) read -p "Enter the username to remove from the sudo group: " username
           sudo deluser "$username" sudo
           echo "User $username removed from the sudo group."
           ;;
        4) ;;
        *) echo "Invalid choice. Try again."; manage_sudo_privileges ;;
    esac
    nine_of_diamonds_menu
}

# View system logs requiring root access
view_system_logs() {
    clear
    echo -e "${CYAN}Select a log file to view:${RESET}"
    logs=(
        "/var/log/syslog"
        "/var/log/auth.log"
        "/var/log/dmesg"
        "/var/log/kern.log"
        "/var/log/boot.log"
    )
    select log in "${logs[@]}" "Cancel"; do
        if [[ $REPLY -gt 0 && $REPLY -le ${#logs[@]} ]]; then
            echo "Displaying: $log"
            sudo less "$log"
            break
        elif [[ $REPLY -eq $((${#logs[@]} + 1)) ]]; then
            echo "Cancelled."
            break
        else
            echo "Invalid choice. Try again."
        fi
    done
    nine_of_diamonds_menu
}

# Schedule a privileged task
schedule_privileged_task() {
    clear
    echo -e "${CYAN}Schedule a task with elevated privileges:${RESET}"
    read -p "Enter the command to schedule (e.g., apt update): " cmd
    read -p "Enter the time for the task (e.g., 'now + 1 minute' or 'tomorrow at 5pm'): " time
    echo "$cmd" | sudo at "$time"
    echo "Task scheduled: '$cmd' at '$time'"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

# View current user and group details
view_user_details() {
    clear
    echo -e "${CYAN}Current user and group details:${RESET}"
    id
    echo "Groups: $(groups)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    nine_of_diamonds_menu
}

nine_of_diamonds_menu
