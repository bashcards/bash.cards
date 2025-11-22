#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'
RED='\033[31m'
GREEN='\033[32m'

# Eight of Hearts Menu
eight_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Eight of Hearts                            |"
    echo "     |                        System and Environment Info                      |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  Select an option to view specific system information:                  |"
    echo "     |                                                                         |"
    echo "     |  1. Host and OS Information                                             |"
    echo "     |  2. Uptime and Load Averages                                            |"
    echo "     |  3. Disk and Memory Usage                                               |"
    echo "     |  4. CPU Details                                                         |"
    echo "     |  5. Network and Open Ports                                              |"
    echo "     |  6. Current Users                                                       |"
    echo "     |  7. All Information                                                     |"
    echo "     |  8. Exit                                                               |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) display_host_info ;;
        2) display_uptime_info ;;
        3) display_disk_memory_info ;;
        4) display_cpu_info ;;
        5) display_network_info ;;
        6) display_current_users ;;
        7) display_all_info ;;
        8) exit ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_hearts_menu ;;
    esac
}

# Host and OS Information
display_host_info() {
    clear
    hostname=$(hostname)
    os=$(uname -s)
    kernel=$(uname -r)
    echo -e "${GREEN}Host and OS Information:${RESET}"
    echo "Hostname: $hostname"
    echo "Operating System: $os"
    echo "Kernel Version: $kernel"
    pause_and_return
}

# Uptime and Load Averages
display_uptime_info() {
    clear
    uptime=$(uptime -p)
    load_avg=$(uptime | awk -F'load average:' '{print $2}')
    echo -e "${GREEN}Uptime and Load Averages:${RESET}"
    echo "System Uptime: $uptime"
    echo "Load Averages: $load_avg"
    pause_and_return
}

# Disk and Memory Usage
display_disk_memory_info() {
    clear
    disk_usage=$(df -h / | awk 'NR==2{print $5}')
    memory_usage=$(free -h | awk 'NR==2{print $3 "/" $2}')
    echo -e "${GREEN}Disk and Memory Usage:${RESET}"
    echo "Disk Usage: $disk_usage"
    echo "Memory Usage: $memory_usage"
    pause_and_return
}

# CPU Details
display_cpu_info() {
    clear
    cpu_model=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^[ \t]*//')
    cpu_cores=$(nproc)
    echo -e "${GREEN}CPU Details:${RESET}"
    echo "CPU Model: $cpu_model"
    echo "Number of Cores: $cpu_cores"
    pause_and_return
}

# Network and Open Ports
display_network_info() {
    clear
    ip=$(hostname -I | awk '{print $1}')
    ext_ip=$(curl -s ifconfig.me)
    open_ports=$(ss -tuln | awk 'NR>1{print $5}' | cut -d: -f2 | sort -n | uniq)
    echo -e "${GREEN}Network and Open Ports:${RESET}"
    echo "Internal IP Address: $ip"
    echo "External IP Address: $ext_ip"
    echo "Open Ports:"
    if [[ -z $open_ports ]]; then
        echo "No open ports detected."
    else
        echo "$open_ports"
    fi
    pause_and_return
}

# Current Users
display_current_users() {
    clear
    users=$(who)
    echo -e "${GREEN}Current Users:${RESET}"
    echo "$users"
    pause_and_return
}

# All Information
display_all_info() {
    clear
    echo -e "${CYAN}Gathering all information...${RESET}"
    display_host_info
    display_uptime_info
    display_disk_memory_info
    display_cpu_info
    display_network_info
    display_current_users
    pause_and_return
}

# Pause and return to the menu
pause_and_return() {
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_hearts_menu
}

eight_of_hearts_menu
