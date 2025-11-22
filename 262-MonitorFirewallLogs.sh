#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

eight_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                            Eight of Clubs                                 |"
    echo "     |                Monitor Firewall Logs for Suspicious Activity             |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card allows you to monitor iptables logs in real time to detect    |"
    echo "     |  possible scanning, brute-force, or malicious traffic patterns.          |"
    echo "     |                                                                          |"
    echo "     |  1. View Last 50 iptables Log Entries                                    |"
    echo "     |  2. Monitor iptables Logs in Real Time                                   |"
    echo "     |  3. Filter Logs for Dropped Packets                                      |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) view_recent_logs ;;
        2) monitor_realtime ;;
        3) filter_dropped ;;
        4) exit 0 ;;
        *) echo "Invalid choice."; sleep 1; eight_of_clubs_menu ;;
    esac
}

view_recent_logs() {
    clear
    echo -e "${CYAN}Last 50 iptables Log Entries${RESET}"
    journalctl -k | grep -i 'iptables' | tail -n 50 || dmesg | grep -i 'iptables' | tail -n 50
    read -n 1 -s -r -p "Press any key to return..."
    eight_of_clubs_menu
}

monitor_realtime() {
    clear
    echo -e "${CYAN}Real-Time iptables Log Monitoring${RESET}"
    journalctl -kf | grep --line-buffered -i 'iptables' || tail -f /var/log/kern.log | grep --line-buffered -i 'iptables'
    read -n 1 -s -r -p "Press any key to return..."
    eight_of_clubs_menu
}

filter_dropped() {
    clear
    echo -e "${CYAN}Dropped Packets (iptables logs)${RESET}"
    journalctl -k | grep -i 'DROP' || dmesg | grep -i 'DROP'
    read -n 1 -s -r -p "Press any key to return..."
    eight_of_clubs_menu
}

eight_of_clubs_menu
