#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Queen of Clubs Card
queen_of_clubs_menu() {
    clear
    echo -e "${CYAN}"
    echo "      _________________________________________________________________________"
    echo "     |                              Queen of Clubs                             |"
    echo "     |                Deploy False Indicators to Mislead Defenders             |"
    echo "     |_________________________________________________________________________|"
    echo "     |                                                                         |"
    echo "     |  This card allows you to deploy decoys, such as false files, logs,      |"
    echo "     |  or network activity, to mislead defenders and analysts.                |"
    echo "     |                                                                         |"
    echo "     |  1. Create False Files                                                  |"
    echo "     |  2. Generate Decoy Log Entries                                          |"
    echo "     |  3. Simulate Network Traffic                                            |"
    echo "     |  4. Exit                                                                |"
    echo "     |_________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) create_false_files ;;
        2) generate_decoy_logs ;;
        3) simulate_network_traffic ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; queen_of_clubs_menu ;;
    esac
}

# Create False Files
create_false_files() {
    clear
    echo -e "${CYAN}Creating false files...${RESET}"
    read -p "Enter the directory to deploy false files: " dir
    mkdir -p "$dir"
    echo "Critical system information" > "$dir/important_data.txt"
    echo "Sensitive credentials" > "$dir/passwords.txt"
    dd if=/dev/urandom of="$dir/dummy_file.bin" bs=1M count=5 status=none
    echo "False files created in $dir."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_clubs_menu
}

# Generate Decoy Log Entries
generate_decoy_logs() {
    clear
    echo -e "${CYAN}Generating decoy log entries...${RESET}"
    read -p "Enter the system log file to append decoy entries (e.g., /var/log/syslog): " log_file
    if [ -f "$log_file" ]; then
        echo "$(date) User 'root' accessed sensitive file: /etc/shadow" >> "$log_file"
        echo "$(date) Connection attempt from suspicious IP: 192.168.1.100" >> "$log_file"
        echo "$(date) Unauthorized login attempt detected." >> "$log_file"
        echo "Decoy log entries added to $log_file."
    else
        echo "Log file $log_file not found."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_clubs_menu
}

# Simulate Network Traffic
simulate_network_traffic() {
    clear
    echo -e "${CYAN}Simulating network traffic...${RESET}"
    read -p "Enter the target IP address for simulated traffic: " target_ip
    read -p "Enter the number of packets to send: " packet_count
    if command -v hping3 &>/dev/null; then
        sudo hping3 -S -p 80 -c "$packet_count" "$target_ip"
        echo "Simulated network traffic sent to $target_ip."
    else
        echo "Error: hping3 is not installed. Please install it to simulate network traffic."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    queen_of_clubs_menu
}

queen_of_clubs_menu
