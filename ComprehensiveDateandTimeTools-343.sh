#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Menu for the Six of Hearts Card
six_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Six of Hearts                               |"
    echo "     |                       Comprehensive Date and Time Tools                  |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides extensive tools to view, modify, and manage the      |"
    echo "     |  system's date and time, including NTP synchronization, time zones,      |"
    echo "     |  and hardware clock adjustments.                                         |"
    echo "     |                                                                          |"
    echo "     |  1. Display Current Date and Time                                        |"
    echo "     |  2. Change Date                                                          |"
    echo "     |  3. Change Time                                                          |"
    echo "     |  4. Synchronize Time with NTP Server                                     |"
    echo "     |  5. View and Change Time Zone                                            |"
    echo "     |  6. Manage Hardware Clock                                                |"
    echo "     |  7. Enable or Disable Automatic Time Synchronization                     |"
    echo "     |  8. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) display_date_time ;;
        2) change_date ;;
        3) change_time ;;
        4) synchronize_time ;;
        5) manage_time_zone ;;
        6) manage_hardware_clock ;;
        7) toggle_auto_sync ;;
        8) exit 0 ;;
        *) echo -e "${RED}Invalid choice. Try again.${RESET}"; sleep 1; six_of_hearts_menu ;;
    esac
}

# Display the current date and time
display_date_time() {
    clear
    echo -e "${CYAN}Current System Date and Time:${RESET} $(date)"
    echo -e "${CYAN}Hardware Clock:${RESET} $(sudo hwclock)"
    echo -e "${CYAN}Automatic Time Sync:${RESET} $(timedatectl show | grep 'NTPSynchronized' | cut -d= -f2)"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Change the system date
change_date() {
    clear
    read -p "Enter the new date (YYYY-MM-DD): " new_date
    if [[ $new_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        sudo date -s "$new_date"
        echo -e "${CYAN}System date changed to $new_date.${RESET}"
    else
        echo -e "${RED}Invalid date format. Please use YYYY-MM-DD.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Change the system time
change_time() {
    clear
    read -p "Enter the new time (HH:MM:SS): " new_time
    if [[ $new_time =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        sudo date -s "$new_time"
        echo -e "${CYAN}System time changed to $new_time.${RESET}"
    else
        echo -e "${RED}Invalid time format. Please use HH:MM:SS.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Synchronize time with an NTP server
synchronize_time() {
    clear
    echo -e "${CYAN}Synchronizing time with NTP server...${RESET}"
    if command -v ntpdate &>/dev/null; then
        sudo ntpdate pool.ntp.org
        echo -e "${CYAN}Time synchronized with NTP server.${RESET}"
    else
        echo -e "${RED}Error: ntpdate is not installed.${RESET}"
        echo "Please install ntpdate using your package manager."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# View and manage the time zone
manage_time_zone() {
    clear
    echo -e "${CYAN}Current Time Zone:${RESET} $(timedatectl | grep 'Time zone')"
    echo -e "${CYAN}Available Time Zones:${RESET}"
    timedatectl list-timezones | less
    echo -e "${CYAN}"
    read -p "Enter the desired time zone (e.g., America/New_York): " new_zone
    if timedatectl set-timezone "$new_zone" &>/dev/null; then
        echo -e "${CYAN}Time zone changed to $new_zone.${RESET}"
    else
        echo -e "${RED}Invalid time zone. Please try again.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Manage the hardware clock
manage_hardware_clock() {
    clear
    echo -e "${CYAN}Current Hardware Clock:${RESET} $(sudo hwclock)"
    echo -e "${CYAN}"
    echo "1. Sync System Clock to Hardware Clock"
    echo "2. Sync Hardware Clock to System Clock"
    echo "3. Exit"
    read -p "Choose an option: " hw_choice
    case $hw_choice in
        1)
            sudo hwclock --hctosys
            echo -e "${CYAN}System clock synchronized to hardware clock.${RESET}"
            ;;
        2)
            sudo hwclock --systohc
            echo -e "${CYAN}Hardware clock synchronized to system clock.${RESET}"
            ;;
        3)
            ;;
        *)
            echo -e "${RED}Invalid choice. Returning to menu.${RESET}"
            ;;
    esac
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

# Enable or disable automatic time synchronization
toggle_auto_sync() {
    clear
    local auto_sync_status=$(timedatectl show | grep 'NTPSynchronized' | cut -d= -f2)
    if [[ $auto_sync_status == "yes" ]]; then
        echo -e "${CYAN}Automatic Time Synchronization is enabled.${RESET}"
        read -p "Do you want to disable it? (y/n): " choice
        if [[ $choice == "y" || $choice == "Y" ]]; then
            sudo timedatectl set-ntp false
            echo -e "${CYAN}Automatic Time Synchronization disabled.${RESET}"
        fi
    else
        echo -e "${CYAN}Automatic Time Synchronization is disabled.${RESET}"
        read -p "Do you want to enable it? (y/n): " choice
        if [[ $choice == "y" || $choice == "Y" ]]; then
            sudo timedatectl set-ntp true
            echo -e "${CYAN}Automatic Time Synchronization enabled.${RESET}"
        fi
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    six_of_hearts_menu
}

six_of_hearts_menu
