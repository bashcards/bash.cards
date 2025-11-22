#!/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

# Menu for the King of Hearts Card
king_of_hearts_menu() {
    clear
    echo -e "${CYAN}"
    echo "      __________________________________________________________________________"
    echo "     |                              King of Hearts                              |"
    echo "     |                  Capture and Analyze Network Packets                     |"
    echo "     |__________________________________________________________________________|"
    echo "     |                                                                          |"
    echo "     |  This card provides a user-friendly interface for capturing and          |"
    echo "     |  analyzing network packets using tshark.                                |"
    echo "     |                                                                          |"
    echo "     |                                                                          |"
    echo "     |  1. Start live packet capture                                            |"
    echo "     |  2. Filter packets by protocol                                           |"
    echo "     |  3. View saved capture files                                             |"
    echo "     |  4. Exit                                                                |"
    echo "     |__________________________________________________________________________|"
    echo -e "${RESET}"
    read -p "Enter your choice: " choice
    case $choice in
        1) start_live_capture ;;
        2) filter_packets ;;
        3) view_capture_files ;;
        4) exit 0 ;;
        *) echo "Invalid choice. Try again."; sleep 1; king_of_hearts_menu ;;
    esac
}

# Start live packet capture
start_live_capture() {
    clear
    echo -e "${CYAN}Starting live packet capture...${RESET}"
    if command -v tshark &>/dev/null; then
        read -p "Enter the network interface to capture packets on (e.g., eth0, wlan0): " interface
        tshark -i "$interface"
    else
        echo -e "${CYAN}Error: tshark is not installed.${RESET}"
        echo "Please install tshark using your package manager or visit https://www.wireshark.org/docs/man-pages/tshark.html."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

# Filter packets by protocol
filter_packets() {
    clear
    echo -e "${CYAN}Filtering packets by protocol...${RESET}"
    if command -v tshark &>/dev/null; then
        read -p "Enter the protocol to filter (e.g., tcp, udp, http): " protocol
        read -p "Enter the network interface to capture packets on (e.g., eth0, wlan0): " interface
        tshark -i "$interface" -f "$protocol"
    else
        echo -e "${CYAN}Error: tshark is not installed.${RESET}"
        echo "Please install tshark using your package manager or visit https://www.wireshark.org/docs/man-pages/tshark.html."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

# View saved capture files
view_capture_files() {
    clear
    echo -e "${CYAN}Viewing saved capture files...${RESET}"
    capture_path="$HOME/tshark_captures"
    if [[ -d "$capture_path" ]]; then
        ls "$capture_path"
        read -p "Enter the filename to view (or type 'cancel' to return): " file_choice
        if [[ $file_choice == "cancel" ]]; then
            echo "Returning to menu..."
        elif [[ -f "$capture_path/$file_choice" ]]; then
            tshark -r "$capture_path/$file_choice"
        else
            echo -e "${CYAN}Error: File $file_choice not found.${RESET}"
        fi
    else
        echo -e "${CYAN}Error: No saved capture files directory found.${RESET}"
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
    king_of_hearts_menu
}

king_of_hearts_menu
