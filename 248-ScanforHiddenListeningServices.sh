#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the Eight of Spades Card
eight_of_spades_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              Eight of Spades                             |"
    echo "     |                      Scan for Hidden Listening Services                  |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides tools to identify hidden or suspicious listening     |"
    echo "     |  services on your network or system for security audit purposes.         |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Scan for listening ports                                             |"
    echo "     |  2. Identify unusual services                                            |"
    echo "     |  3. Generate a detailed report                                           |"
    echo "     |  4. Exit                                                                 |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) scan_listening_ports ;;
        2) identify_unusual_services ;;
        3) generate_detailed_report ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; eight_of_spades_menu ;;
    esac
}

# Scan for listening ports
scan_listening_ports() {
    clear
    echo -e "${CYAN}Scanning for listening ports...${RESET}"
    sudo netstat -tulnp | grep LISTEN
    echo -e "${CYAN}Use this information to identify suspicious listening services.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

# Identify unusual services
identify_unusual_services() {
    clear
    echo -e "${CYAN}Identifying unusual services...${RESET}"
    sudo netstat -tulnp | grep LISTEN | awk '{print $4, $7}' | while read -r line; do
        port=$(echo "$line" | awk '{print $1}')
        process=$(echo "$line" | awk '{print $2}' | cut -d '/' -f 2)
        if [[ ! "$process" =~ (sshd|nginx|apache2|mysql|postgresql) ]]; then
            echo "Unusual service detected on port $port: $process"
        fi
    done
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

# Generate a detailed report
generate_detailed_report() {
    clear
    echo -e "${CYAN}Generating a detailed report...${RESET}"
    report_file="listening_services_$(date +%Y%m%d%H%M%S).log"
    sudo netstat -tulnp > "$report_file"
    echo -e "${CYAN}Report saved to $report_file.${RESET}"
    read -n 1 -s -r -p "Press any key to return to the menu..."
    eight_of_spades_menu
}

eight_of_spades_menu
